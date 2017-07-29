function updateApp(filename, mcode)
% UPDATEAPP Update Matlab App (.mlapp) code from editor

if nargin < 2
    mcode = mlapp.getCodeFromActiveDocument();
end
lines = matlab.desktop.editor.textToLines(mcode);

% Update data 
appData                        = mlapp.getAppData(filename);
appData.CodeData.GeneratedCode = lines;

% Update UIFigure by running the app from %TMP% folder
tempapp     = fullfile(tempdir, [appData.CodeData.GeneratedClassName, '.m']);
fid         = fopen(tempapp,'w');
cleanup     = onCleanup(@() fclose(fid));
fwrite(fid, mcode, 'char');
appservices = appdesigner.internal.service.AppManagementService.instance();
app         = appservices.runApp(tempapp);
s = struct(app.UIFigure);
appData.UIFigure = appservices.getFigure(app);

componentLoadingFactory = matlab.ui.control.internal.view.ComponentLoadingProxyViewFactory();

% Start from processHgComponent, we need to create DesignTimeProperties
% componentLoadingFactory.createProxyView()

controller = matlab.ui.control.internal.model.DesignTimeComponentFactory.createController(...
                'matlab.ui.Figure', appData.UIFigure, [], []);

            factoryManager = matlab.ui.control.internal.view.ComponentProxyViewFactoryManager.Instance;
            componentLoadingFactory = factoryManager.ProxyViewFactory;
            pvPairs = controller.restoreFromModel();
            % Append DesingTimeProperties to hg component, so all
            % the hg controllers do not have to do that
            pvPairs = [pvPairs, {'DesignTimeProperties', component.DesignTimeProperties}];
            componentLoadingFactory.createProxyView(class(component), ...
                parentController, ...
                pvPairs);

    peerModelManager = appdesigner.internal.application.AppDesignEnvironment.getPeerModelManager( ...
        appdesigner.internal.application.AppDesignEnvironment.NameSpace);                
    
    % create the AppDesignerModel
    componentAdapterMap = appdesigner.internal.application.appmetadata.createComponentAdapterMap();
    parentModel = appdesigner.internal.model.AppDesignerModel(componentAdapterMap, peerModelManager);

    % construct an AppModel
    proxyView = appdesservices.internal.peermodel.PeerNodeProxyView(s.Controller.ProxyView.PeerNode);
    proxyView
    model = appdesigner.internal.model.AppModel(parentModel, s.Controller.ProxyView, appData);
    
    appdesservices.internal.peermodel.PeerNodeProxyView

% Re-create appdata with updated info (except metadata)
appData = appdesigner.internal.serialization.app.AppData(appData.UIFigure,  appData.CodeData, appData.Metadata);

fw = appdesigner.internal.serialization.FileWriter(filename);
fw.writeAppDesignerData(appData)
fw.writeMATLABCodeText(mcode);
a
% Clear the class
[path, name] = fileparts(filename);
clear(name);
delete(app)
end

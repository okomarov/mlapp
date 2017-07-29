function appData = getAppData(filename)
% GETAPPDATA Get application data of a Matlab App (.mlapp)
appLoadingFactory = appdesigner.internal.serialization.AppLoadingFactory.instance();
appData = appLoadingFactory.getAppData(filename);
end

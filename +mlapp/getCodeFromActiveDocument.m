function mcode = getCodeFromActiveDocument()
% GETCODEFROMACTIVEDOCUMENT Get code from Matlab editor
doc = matlab.desktop.editor.getActive;
mcode = doc.Text;
end

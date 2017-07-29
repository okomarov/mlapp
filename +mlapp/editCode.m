function editCode(filename)
% EDITCODE Open code from a Matlab App (.mlapp) in a new document 
matlab.desktop.editor.newDocument(mlapp.getCode(filename))
end

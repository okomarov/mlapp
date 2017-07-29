function mcode = getCode(filename)
% GETCODE Get code from Matlab App (.mlapp) 
mcode = matlab.internal.getcode.mlappfile(filename);
end

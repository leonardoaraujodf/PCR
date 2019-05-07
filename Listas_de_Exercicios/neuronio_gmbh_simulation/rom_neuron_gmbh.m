clc;
clear all;
close all;

N=100; % numero de vetores de teste aleatorios
EW=8; % tamanho do expoente
FW=18; % tamanho da mantissa

floatx_fid = fopen('floatx.txt','w');
floata_fid = fopen('floata.txt','w');
floatb_fid = fopen('floatb.txt','w');
floatc_fid = fopen('floatc.txt','w');

binx_fid = fopen('binx.txt','w');
bina_fid = fopen('bina.txt','w');
binb_fid = fopen('binb.txt','w');
binc_fid = fopen('binc.txt','w');

max_values = 20; % os valores das entradas e constantes estarao entre -10 e 10

rng(31051995);

x = max_values*(rand(1,N)-0.5);
a = max_values*(rand(1,N)-0.5);
b = max_values*(rand(1,N)-0.5);
c = max_values*(rand(1,N)-0.5);

fprintf(floatx_fid,'%f\n',x);
fprintf(floata_fid,'%f\n',a);
fprintf(floatb_fid,'%f\n',b);
fprintf(floatc_fid,'%f\n',c);

for i=1:N
    
    x_bin = float2bin(EW,FW,x(i));
    a_bin = float2bin(EW,FW,a(i));
    b_bin = float2bin(EW,FW,b(i));
    c_bin = float2bin(EW,FW,c(i));
    
    fprintf(binx_fid,'%s\n',x_bin);
    fprintf(bina_fid,'%s\n',a_bin);
    fprintf(binb_fid,'%s\n',b_bin);
    fprintf(binc_fid,'%s\n',c_bin);
    
end

fclose(floatx_fid);
fclose(floata_fid);
fclose(floatb_fid);
fclose(floatc_fid);

fclose(binx_fid);
fclose(bina_fid);
fclose(binb_fid);
fclose(binc_fid);
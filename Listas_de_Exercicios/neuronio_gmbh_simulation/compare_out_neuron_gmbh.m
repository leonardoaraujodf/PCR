clc;
clear all;
close all;
format long;

N=100; % numero de vetores de teste aleatorios
EW=8; % tamanho do expoente
FW=18; % tamanho da mantissa

res_neuron_fid = fopen('res_neuron.txt','r');

res_neuron_bin = fscanf(res_neuron_fid,"%s");
res_neuron_sim = zeros(1,N);
fclose(res_neuron_fid);

floatx_fid = fopen('floatx.txt','r');
floata_fid = fopen('floata.txt','r');
floatb_fid = fopen('floatb.txt','r');
floatc_fid = fopen('floatc.txt','r');

x = fscanf(floatx_fid,'%f');
a = fscanf(floata_fid,'%f');
b = fscanf(floatb_fid,'%f');
c = fscanf(floatc_fid,'%f');

for i=1:N
    
    if i==1
        res_neuron_sim(i) = bin2float(res_neuron_bin(i:(27*i)),EW,FW);
    else
        res_neuron_sim(i) = bin2float(res_neuron_bin((27*(i-1) + 1):27*i),EW,FW);
    end
    
end

res_neuron_real = transpose(a.*x.^2 + b.*x + c);
erro = (res_neuron_sim - res_neuron_real).^2;
MSE = sum(erro)/N;
plot(erro);

fclose(floatx_fid);
fclose(floata_fid);
fclose(floatb_fid);
fclose(floatc_fid);
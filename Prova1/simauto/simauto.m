clc;
clear all;
close all;

% Nome: Leonardo Amorim de Ara�jo
% Matricula: 150039921

rng(150039921,'twister');
format long;
% numero de vetores de teste
EW = 8;
FW = 18;
N = 100;

% covariancia do sensor de ultrassom

sigma_k_max = 0.25;
sigma_k_min = 0.1;

length_sigma_k = sigma_k_max - sigma_k_min;
sigma_k = length_sigma_k*(rand()) + sigma_k_min;
sigma_k_bin = float2bin(EW,FW,sigma_k);

% covariancia do sensor infravermelho

sigma_z_max = 0.75;
sigma_z_min = 0.5;

length_sigma_z = sigma_z_max - sigma_z_min;
sigma_z = length_sigma_z*(rand()) + sigma_z_min;
sigma_z_bin = float2bin(EW,FW,sigma_z);


% Valor da distancia media
media = 100;

% Vetor de valores do sensor infravermelho com dist. normal. Media e 
% variancia setados

x_ir = media + sigma_z*randn(1,N);

% Vetor de valores do sensor ultrassom com dist. normal. Media e 
% variancia setados

x_ul = media + sigma_k*randn(1,N);

fid_x_ir_float = fopen('x_ir_float.txt','w');
fid_x_ul_float = fopen('x_ul_float.txt','w');

fprintf(fid_x_ir_float,"%f\n",x_ir);
fprintf(fid_x_ul_float,"%f\n",x_ul);

fid_x_ir_bin = fopen('x_ir_bin.txt','w');
fid_x_ul_bin = fopen('x_ul_bin.txt','w');

% Inicializando os arquivos .coe
fid_x_ir_coe = fopen('x_ir_bin.coe','w');
fid_x_ul_coe = fopen('x_ul_bin.coe','w');

fprintf(fid_x_ir_coe,'; This .COE file specifies the contents for\n');
fprintf(fid_x_ir_coe,'; a block memory of depth=100, and width = 27.\n');
fprintf(fid_x_ir_coe,'memory_initialization_radix=2;\n');
fprintf(fid_x_ir_coe,'memory_initialization_vector=\n');

fprintf(fid_x_ul_coe,'; This .COE file specifies the contents for\n');
fprintf(fid_x_ul_coe,'; a block memory of depth=100, and width = 27.\n');
fprintf(fid_x_ul_coe,'memory_initialization_radix=2;\n');
fprintf(fid_x_ul_coe,'memory_initialization_vector=\n');


for i=1:N
    x_ir_bin = float2bin(EW,FW,x_ir(i));
    x_ul_bin = float2bin(EW,FW,x_ul(i));
    
    fprintf(fid_x_ir_bin,'%s\n',x_ir_bin);
    fprintf(fid_x_ul_bin,'%s\n',x_ul_bin);
    
    % printing values in the .COE files
    
    if i < 100
        fprintf(fid_x_ir_coe,'%s,\n',x_ir_bin);
        fprintf(fid_x_ul_coe,'%s,\n',x_ul_bin);
    else
        fprintf(fid_x_ir_coe,'%s;\n',x_ir_bin);
        fprintf(fid_x_ul_coe,'%s;\n',x_ul_bin);
    end
    
end

fclose(fid_x_ir_float);
fclose(fid_x_ul_float);
fclose(fid_x_ir_bin);
fclose(fid_x_ul_bin);
fclose(fid_x_ir_coe);
fclose(fid_x_ul_coe);



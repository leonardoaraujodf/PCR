clc;
clear all;
close all;

fid_x_ir_float = fopen('x_ir_float.txt','r');
fid_x_ul_float = fopen('x_ul_float.txt','r');
N = 100;
EW = 8;
FW = 18;

x_ir = transpose(fscanf(fid_x_ir_float,'%f'));
x_ul = transpose(fscanf(fid_x_ul_float,'%f'));

fclose(fid_x_ir_float);
fclose(fid_x_ul_float);

sigma_z = 0.588096934460478;
sigma_k_init = 0.191241597595514;

sigma_k = zeros(1,100);
sigma_k(1) = sigma_k_init;
G_kp1 = zeros(1,100);
x_fus = zeros(1,100);

% Estes sao os valores gerados pelo testbench
fid_x_fus = fopen('x_fus_bin.txt','r');
x_fus_bin = fscanf(fid_x_fus,"%s");
fclose(fid_x_fus);
x_fus_sim = zeros(1,N);


for i=1:N
    G_kp1(i) = (sigma_k(i))/(sigma_k(i) + sigma_z);    
    x_fus(i) = x_ul(i) + G_kp1(i)*(x_ir(i) - x_ul(i));
    if(i < N)
        sigma_k(i+1) = sigma_k(i) - G_kp1(i)*sigma_k(i);
    end
    
    if i==1
        x_fus_sim(i) = bin2float(x_fus_bin(i:(27*i)),EW,FW);
    else
        x_fus_sim(i) = bin2float(x_fus_bin((27*(i-1) + 1):27*i),EW,FW);
    end
    
end

disp('Plotando grafico do erro quadratico para cada amostra');
erro = (x_fus_sim - x_fus).^2;
plot(erro);
xlabel('Numero da amostra');
ylabel('Valor do Erro Quadratico');
disp('O erro quadratico medio e:');
MSE = sum(erro)/N









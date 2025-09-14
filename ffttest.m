%初期化
clear all
close all

%サンプリング周波数
fs = 500;

%データポイント数
nt = 500;

%時刻ベクトル
T = (0:nt-1)/fs;

%周波数ベクトル
K = (0:nt/2)'*fs/nt;

%サンプルデータの作成
% 10Hzで振幅1のサイン波と40Hzで振幅0.5のサイン波の和
x = 1*sin(2*pi*10*T) + 0.5*sin(2*pi*40*T);
% xにノイズを加えた解析対象のデータ
y = x + 2*randn(size(T));

%Figureウインドウオープン
figure;

%生波形のプロット
subplot(2,1,1)
plot(T,y)
xlabel("Time (s)")

%周波数解析
Y = fft(y)/nt;
A = 2*abs(Y);
A(1) = abs(Y(1));

%振幅スペクトルのプロット
subplot(2,1,2)
plot(K(1:51),A(1:51),"-r")
xlabel("Frequency (Hz)")
ylabel("|Y(f)|")


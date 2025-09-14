clear all
close all

%データ読み込み
load "A2.mat";    %解析データを読み込む
EEG = EEG2;       %課題ごとに違う名前がついている脳波データ(EEG1など)を同じ名前EEGに変更する

%チャンネル名を読み込む
load "ch.mat"; %ここは変えない
%サンプリング周波数
fs = 500; %ここは変えない




%周波数解析のために、先にデータポイント数を決めないといけない
%ここではタスク全体のデータを使うので次のようにしておく。
nt = length(EEG);

%時刻ベクトル
T = (0:nt-1)/fs;

%周波数ベクトル
K = (0:nt/2)'*fs/nt;

 %座標データ
load("xylabch.mat");
%Figureウインドウオープン
figure;

for n=1:19 %何チャンネルまで解析するか？
  %周波数解析
  y = detrend(EEG(:,n),1);
  Y = fft(y)/nt;
  A = 2*abs(Y);
  A(1) = abs(Y(1));
  %振幅スペクトルのプロット
  V1(n) = mean(A(find(K>=4 & K<8)));%theta
  V2(n) = mean(A(find(K>=8 & K<14)));%alpha
  V3(n) = mean(A(find(K>=14 & K<30)));%beta
  V4(n) = mean(A(find(K>=30 & K<55)));%gamma
end
[XQ,YQ] = meshgrid(-0.6:0.01:0.6, -0.6:0.01:0.6);
VQ1 = griddata(xch, ych, V1, XQ, YQ);
subplot(2, 2, 1);
imagesc(XQ, YQ, VQ1, [0 1]);
colorbar
axis equal
axis xy
axis off
title({'Mean \theta'})
set(gca, 'fontsize', 20)
for n=1:19
    text(xch(n),ych(n),ch(n),"HorizontalAlignment", "center", "FontSize", 15, "Color", "w")
endfor


VQ2 = griddata(xch, ych, V2, XQ, YQ);
subplot(2, 2, 2);
imagesc(XQ, YQ, VQ2,[0 1]);
colorbar
axis equal
axis xy
axis off
title({'Mean \alpha'})
set(gca, 'fontsize', 20)
for n=1:19
    text(xch(n),ych(n),ch(n),"HorizontalAlignment", "center", "FontSize", 15, "Color", "w")
endfor

VQ3 = griddata(xch, ych, V3, XQ, YQ);
subplot(2, 2, 3);
imagesc(XQ, YQ, VQ3, [0 1]);
colorbar
axis equal
axis xy
axis off
title({'Mean \beta'})
set(gca, 'fontsize', 20)
for n=1:19
    text(xch(n),ych(n),ch(n),"HorizontalAlignment", "center", "FontSize", 15, "Color", "w")
endfor

VQ4 = griddata(xch, ych, V4, XQ, YQ);
subplot(2, 2, 4);
imagesc(XQ, YQ, VQ4, [0 1]);
colorbar
axis equal
axis xy
axis off
title({'Mean \gamma'})
set(gca, 'fontsize', 20)
for n=1:19
    text(xch(n),ych(n),ch(n),"HorizontalAlignment", "center", "FontSize", 15, "Color", "w")
endfor



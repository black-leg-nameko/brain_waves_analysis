clear all
close all

%データ読み込み
load "A2.mat";    %解析データを読み込む
EEG = EEG2;       %課題ごとに違う名前がついている脳波データ(EEG1など)を同じ名前EEGに変更する

%頭皮上
load "spxylabch.mat";
width = 0.12;
height = 0.08;

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
idx = find(K<30); %表示したい周波数の上限を指定

%Figureウインドウオープン
figure;

annotation("ellipse", [0.024 0.03 0.97 0.89]);
annotation("line", [0.45 0.5], [0.92 0.98]);
annotation("line", [0.55 0.5], [0.92 0.98]);

for n=1:19 %何チャンネルまで解析するか？
  %周波数解析
  y = detrend(EEG(:,n),1);
  Y = fft(y)/nt;
  A = 2*abs(Y);
  A(1) = abs(Y(1));
  %振幅スペクトルのプロット
    my1 = mean(A(find(K>=4 & K<8)));%theta
    my2 = mean(A(find(K>=8 & K<14)));%alpha
    my3 = mean(A(find(K>=14 & K<30)));%beta
    my4 = mean(A(find(K>=30 & K<55)));%gamma

    left = spxch(n)-width/2;
    bottom = spych(n)-height/2;
    subplot("position", [left, bottom, width, height])

    bar([1:4], [my1 my2 my3 my4])
    if strcmp(ch(n), "O2");
        xlabel("Band")
        ylabel("Mean|Y(f)|")
    endif
    title(ch(n))
    set(gca(), "xticklabel", {'\theta', '\alpha', '\beta', '\gamma'})
    ylim([0 3])
end

%初期化
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

%Figureウインドウオープン
figure;

for n=1:19 %何チャンネルまで解析するか？
  %周波数解析
  y = detrend(EEG(:,n),1);
  Y = fft(y)/nt;
  A = 2*abs(Y);
  A(1) = abs(Y(1));
  %振幅スペクトルのプロット
  subplot(4, 5, n)
  my1 = mean(A(find(K>=4 & K<8)));%theta
  my2 = mean(A(find(K>=8 & K<14)));%alpha
  my3 = mean(A(find(K>=14 & K<30)));%beta
  my4 = mean(A(find(K>=30 & K<55)));%gamma

  bar([1:4], [my1 my2 my3 my4])
  title(ch(n))
  xlabel("Band")
  ylabel("Mean|Y(f)|")
  %xticks()
  %xticklabels({'\theta', '\alpha', '\beta', '\gamma'})
  set(gca(), "xticklabel", {'\theta', '\alpha', '\beta', '\gamma'})
  ylim([0 3])

    %軸のレンジと目盛りを調整する
    %以下のパーセント記号を外し、表示したい最大値や間隔に適当な数値を入れる
    %繰り返し実行して、ちょうどいい目盛りの間隔や最大値を探す

    %xlim([0 表示したい最大値])
    %xticks([0:10:30])
    %ylim([0 表示したい最大値])
    %yticks([0:間隔:表示したい最大値])
end

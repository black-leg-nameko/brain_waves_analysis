clear all
close all
%データ読み込み
load "A1.mat";    %解析データを読み込む
EEG = EEG1;       %課題ごとに違う名前がついている脳波データ(EEG1など)を同じ名前EEGに変更する
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
  kmax = 30;
  tmax = 10;
  S = zeros(kmax, tmax);
  %周波数解析
  y = detrend(EEG(:,n),1);
  Y = fft(y)/nt;
  A = 2*abs(Y);
  A(1) = abs(Y(1));
  for dt=1:tmax
    dtidx=fs*(dt-1)+1:fs*dt;
    y = detrend(EEG(dtidx,n),1);
    dnt = 1*fs;
    dK = (0:dnt/2)'*fs/dnt;
    Y = fft(y)/dnt;
    A = 2 * abs(Y);
    for k=1:kmax
      dkidx=find(dK>=k-1 & dK<k);
      B(k) = mean(A(dkidx));
    endfor
    S(:, dt) = B';
  endfor
  %振幅スペクトルのプロット
  subplot(4, 5, n)
  imagesc(S, [0 5])
  axis xy
  if strcmp(ch(n), "O1");
    xlabel("Time (s)")
    ylabel("Frequency (Hz)")
  endif
  ylim([0 30])
  yticks([0:10:30])
  cb=colorbar
  title(ch(n))
  set(gca,"fontsize",9)
  set(cb, "fontsize", 9)
end

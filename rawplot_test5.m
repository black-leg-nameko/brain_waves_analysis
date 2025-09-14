clear all
close all

load "A2.mat";
load "ch.mat";

figure
for n=1:19
  subplot(4, 5, n)
  data = EEG2(2501:3000, n);
  nt = length(data);
  time = [0: nt-1]'/500;
  plot(time, data)
  title(ch(n))
  end

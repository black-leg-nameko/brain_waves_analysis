clear all;
close all;

load "A1.mat";
load "ch.mat";

time = [0:499]/500;

figure
for n = 1:19
  subplot(4, 5, n)
  data = EEG1(1501:2000, n);
  plot(time, data)
  title(ch(n))
  end

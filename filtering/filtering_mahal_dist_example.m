addpath( '~/Code/PointCloudGenerator/' );
addpath( '~/Code/filtering/mahalanobis' );
a = 50;
b = 40;
r = 10;
padding = 3;
T = 0:.001:2*pi;
x = ones(size(T,2),1);
y = ones(size(T,2),1);

% parametric equation for a circle
for i = 1:size(x,1)
   x(i) = a + r*cos(T(i));
   y(i) = b + r*sin(T(i));    
end

N = size(T,2);

X_a = min( x ) - padding;
X_b = max( x ) + padding;
Y_a = min( y ) - padding;
Y_b = max( y ) + padding;

X_r = X_a + (X_b-X_a).*rand(N,1);
Y_r = Y_a + (Y_b-Y_a).*rand(N,1);
x = [x ;X_r];
y = [y ;Y_r];

q_x = ones(size(x));
f = ones(size(x));
k = 10;
h = 1;
X_vec = [x y];
for i=1:size(X_vec,1)
    [q_x(i),id,dist,f(i)] = kernel_density_estimate( X_vec,i,k,h);
end

plot(x,y,'.','markersize',0.01 );
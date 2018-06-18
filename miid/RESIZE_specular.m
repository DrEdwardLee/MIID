function [ varargout ] = RESIZE( Size, varargin )

mask = varargin{1};

%% ���õ���ΧĿ�����С����
[row, col] = find(mask == 1);
row = min(row):max(row);
col = min(col):max(col);

for i = 1:nargin-1
    temp = varargin{i};
    varargin{i} = temp(row, col, :);
end

%% ����
Size = min(Size/(max(length(row),length(col))),1);
for i = 1:nargin-1
    temp = varargin{i};
    varargin{i} = imresize(temp, Size);
end

%% ����mask
for i = 1:nargin-1
    varargout{i} = varargin{i} .* repmat(varargin{1}, [1, 1, size(varargin{i}, 3)]); %#ok<AGROW>
end

%% 2. Non-binary LDPC coding for subframe_2 and subframe_3

% Define the column indices for non-zero elements (0-based, will +1 later)
cols_data_1 = [...
    11, 62, 102, 150;
    4, 90, 131, 177;
    ... % (truncated for brevity)
    42, 55, 134, 157;
    27, 92, 110, 181];

% Define the corresponding values for each column position
values_data_1 = [...
    35, 13, 51, 60;
    1, 44, 53, 24;
    ... % (truncated for brevity)
    44, 30, 24, 1;
    53, 24, 1, 44];

% Create a 100x200 zero matrix to store the LDPC coding matrix
matrix_1 = zeros(100, 200);

% Fill the matrix with the given values at specified column positions
for i = 1:size(cols_data_1,1)  % Iterate over rows
    for j = 1:size(cols_data_1,2)  % Iterate over columns in each row
        col_index = cols_data_1(i,j) + 1;  % Convert 0-based index to 1-based (MATLAB indexing)
        matrix_1(i, col_index) = values_data_1(i,j);  % Assign the value
    end
end

% Get the matrix size
[numRows, numCols] = size(matrix_1);

% Print column headers
fprintf('%-8s', '');  % Leave space for row labels
for col = 1:numCols
    fprintf('%-8s', sprintf('C%03d', col));  % Print column labels as C001, C002, ...
end
fprintf('\n');

% Print matrix row by row with row index
for row = 1:numRows
    fprintf('%-8s', sprintf('Row %3d:', row));  % Row label
    for col = 1:numCols
        fprintf('%-8d', matrix_1(row, col));  % Print matrix element
    end
    fprintf('\n');
end

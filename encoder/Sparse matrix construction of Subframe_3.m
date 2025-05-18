%% === Subframe 3: Construct LDPC Matrix ===

% Define column indices for non-zero elements (0-based)
cols_data_2 = [...
    14 35 56 70;
     1 27 45 54;
     2 26 61 79;
    ... % truncated for brevity
    15  6  1 45;
     1 44 53 24];

% Define the corresponding values to be filled at each (row, column) position
values_data_2 = [...
    30 24 1 44;
    51 60 35 13;
     6  1 45 15;
    ... % truncated for brevity
    15  6  1 45;
     1 44 53 24];

% Determine matrix size and initialize a 44×88 zero matrix
% The number of rows is equal to the number of entries
% The number of columns is max(cols_data_2) + 1, since indexing is 0-based
[numRows_2, numCols_entry] = size(cols_data_2);
matrix_2 = zeros(numRows_2, 88);  % Final matrix will be 44×88

% Fill the matrix with non-zero values from the input data
for i = 1:numRows_2              % Loop over rows
    for j = 1:numCols_entry      % Loop over each entry in the row
        col_index = cols_data_2(i,j) + 1;  % Convert to 1-based MATLAB index
        matrix_2(i, col_index) = values_data_2(i,j);  % Set value at position
    end
end

% === Print matrix_2 with column headers ===

[numRows2, numCols2] = size(matrix_2);

% Print column headers (e.g., C001, C002, ..., C088)
fprintf('%-8s', '');  % Leave space for row labels
for col = 1:numCols2
    fprintf('%-8s', sprintf('C%03d', col));
end
fprintf('\n');

% Print each row with row index and values
for row = 1:numRows2
    fprintf('%-8s', sprintf('Row %3d:', row));  % e.g., Row  1:
    for col = 1:numCols2
        fprintf('%-8d', matrix_2(row, col));    % Print matrix values
    end
    fprintf('\n');
end

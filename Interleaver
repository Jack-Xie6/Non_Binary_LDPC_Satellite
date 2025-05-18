%% === Block Interleaver Construction and Column-wise Readout ===

% === Helper function: Convert a vector of decimal numbers into a binary bitstream ===
function bin_vec = convertToBinaryVector(dec_vector, bit_length)
    bin_vec = [];  % Initialize empty binary vector
    for i = 1:length(dec_vector)
        % Convert each decimal number to a binary string of fixed bit length
        bin_str = dec2bin(dec_vector(i), bit_length);  % Pad with leading zeros
        % Convert character array '0'/'1' into numeric array 0/1
        bits = bin_str - '0';
        % Concatenate bits into the final bitstream
        bin_vec = [bin_vec, bits];
    end
end

% Convert encoded symbols from subframe_2 and subframe_3 to bitstreams
binary_encoded_1 = convertToBinaryVector(encoded.x, 6);    % 1×1200 bit vector
binary_encoded_2 = convertToBinaryVector(encoded_2.x, 6);  % 1×528 bit vector

% Build the block interleaver matrix using the two bitstreams
blockInterleaver = createBlockInterleaver(binary_encoded_1, binary_encoded_2);

% Display the interleaver matrix row by row
fprintf('Block Interleaver Matrix (displayed row by row):\n');
for row = 1:size(blockInterleaver, 1)
    fprintf('Row %2d: ', row);
    fprintf('%4d ', blockInterleaver(row, :));
    fprintf('\n');
end

%% === Subfunction: Construct the Block Interleaver Matrix ===
function blockInterleaver = createBlockInterleaver(binary_encoded_1, binary_encoded_2)
    % Constructs a 36×48 block interleaver matrix.
    %
    % Input:
    %   binary_encoded_1 - bitstream from subframe_2 (1200 bits)
    %   binary_encoded_2 - bitstream from subframe_3 (528 bits)
    %
    % Output:
    %   blockInterleaver - 36×48 matrix filled row by row as follows:
    %       - Every 3-row cycle: first 2 rows from subframe_2, 1 row from subframe_3
    %       - Final 3 rows: remaining data from subframe_2

    M = 36;  % Number of rows
    N = 48;  % Number of columns
    blockInterleaver = zeros(M, N);  % Preallocate the matrix

    % Initialize reading indices for both input bitstreams
    index1 = 1;  % Index for binary_encoded_1 (subframe_2)
    index2 = 1;  % Index for binary_encoded_2 (subframe_3)
    currentRow = 1;

    % Fill the first 33 rows in 11 cycles (each cycle: 2 rows from subframe_2, 1 from subframe_3)
    for cycle = 1:11
        for r = 1:2
            if currentRow > M
                error('Exceeded matrix row size');
            end
            blockInterleaver(currentRow, :) = binary_encoded_1(index1:index1 + N - 1);
            index1 = index1 + N;
            currentRow = currentRow + 1;
        end

        if currentRow > M
            error('Exceeded matrix row size');
        end
        blockInterleaver(currentRow, :) = binary_encoded_2(index2:index2 + N - 1);
        index2 = index2 + N;
        currentRow = currentRow + 1;
    end

    % Fill the last 3 rows using remaining subframe_2 bits
    for r = 1:3
        if currentRow > M
            error('Exceeded matrix row size');
        end
        blockInterleaver(currentRow, :) = binary_encoded_1(index1:index1 + N - 1);
        index1 = index1 + N;
        currentRow = currentRow + 1;
    end

    % Check wheth

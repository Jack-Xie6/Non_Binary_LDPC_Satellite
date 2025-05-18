% === Step 1: Column Swap ===
% Swap the left and right halves of the matrix (columns 1–100 and 101–200)
matrix_new_1 = [matrix_1(:, 101:200), matrix_1(:, 1:100)];

% === Step 2: Define the primitive polynomial for GF(2^6) ===
% p(x) = 1 + x + x^6 → binary: 1000011 → decimal: 67
poly = bin2dec('1000011');

% Convert the matrix into elements over GF(2^6)
H_gf = gf(matrix_new_1, 6, poly);

% === Step 3: Parameters ===
k_1 = 100;      % Number of message symbols
n_1 = 200;      % Total codeword length

% Split the matrix into H1 and H2 by column blocks
H1_1 = H_gf(:, 1:k_1);        % H1: First 100 columns
H2_2 = H_gf(:, k_1+1:n_1);    % H2: Last 100 columns

% Check rank of H1 (optional)
rankH1 = rank(H1_1);

% === Step 4: Inversion and generator matrix construction ===
% Compute inverse of H2 (must be non-singular in GF)
H2_inv_1 = inv(H2_2);

% Compute P = H2⁻¹ * H1 over GF
P_1 = H2_inv_1 * H1_1;
P_transpose_1 = P_1.';

% Construct k×k identity matrix over GF
I_k_1 = gf(eye(k_1), 6, poly);

% Final generator matrix: G = [Iₖ | Pᵗ]
G_1 = [I_k_1, P_transpose_1];

% === Step 5: Print the generator matrix (G.x is the raw uint32 values) ===
GX = G_1.x;
[numRows, numCols] = size(GX);

% Print column headers
fprintf('%-8s', '');
for col = 1:numCols
    fprintf('%-8s', sprintf('C%03d', col));
end
fprintf('\n');

% Print each row with row index
for row = 1:numRows
    fprintf('%-8s', sprintf('Row %3d:', row));
    for col = 1:numCols
        fprintf('%-8d', GX(row, col));
    end
    fprintf('\n');
end

% === Step 6: Encode a 1×100 message vector ===

% Define message data as 6-bit binary strings (cell array of char)
data_1 = { ...
    '001010', '110010', '010011', '100001', ...  % (truncated for brevity)
    '100000', '110100', '110010' };

% Convert binary strings to decimal integers
M_1 = zeros(1, 100);
for i = 1:100
    M_1(i) = bin2dec(data_1{i});
end

% Display the 1×100 decimal message vector
disp(M_1);

% Convert the message to GF(2^6) elements
prim_poly = 67;  % Same primitive polynomial
GF_M_1 = gf(M_1, 6, prim_poly);

% Display GF(2^6) message vector
disp(GF_M_1);

% === Step 7: Perform encoding: C = M × G ===
encoded = GF_M_1 * G_1;

% Extract and print raw encoded values
encoded_x = encoded.x;
total_elements = length(encoded_x);
group_size = 10;

fprintf('Encoded result (in decimal), displayed 10 per line:\n');
for idx = 1:group_size:total_elements
    end_idx = min(idx + group_size - 1, total_elements);
    for j = idx:end_idx
        fprintf('%d ', encoded_x(j));
    end
    fprintf('\n');
end

%% === LDPC Encoding for Subframe 3 over GF(2^6) ===

% Define the primitive polynomial for GF(2^6)
% Using p(x) = 1 + x + x^6 → binary: '1000011' → decimal: 67
poly = bin2dec('1000011');

% Convert the binary matrix to GF(2^6) field elements
H_gf = gf(matrix_2, 6, poly);

% Set code parameters: total length n_2 = 88, message length k_2 = 44
% So, parity length = 88 - 44 = 44
k_2 = 44;
n_2 = 88;

% Partition the parity-check matrix into H1 and H2 by column
H1_2 = H_gf(:, 1:k_2);        % First 44 columns → H1
H2_2 = H_gf(:, k_2+1:n_2);    % Last 44 columns → H2

% Optional: Check the rank of H1
rankH2 = rank(H1_2);
disp(rankH2);

% Compute the inverse of H2 (in GF(2^6))
H2_inv_2 = inv(H2_2);

% Compute matrix P = H2⁻¹ * H1 (multiplication in GF)
P_2 = H2_inv_2 * H1_2;
P_transpose_2 = P_2.';

% Construct identity matrix of size k_2 × k_2 over GF(2^6)
I_k_2 = gf(eye(k_2), 6, poly);

% Construct the generator matrix: G_2 = [I | Pᵗ]
G_2 = [I_k_2, P_transpose_2];

% Display generator matrix G_2 (in GF format)
disp(G_2);

% === Output underlying uint32 values of G_2.x ===
GX = G_2.x;
[numRowsGX, numColsGX] = size(GX);

fprintf('\nRaw values of generator matrix G_2:\n');
fprintf('%-8s', '');
for col = 1:numColsGX
    fprintf('%-8s', sprintf('C%03d', col));
end
fprintf('\n');

for row = 1:numRowsGX
    fprintf('%-8s', sprintf('Row %3d:', row));
    for col = 1:numColsGX
        fprintf('%-8d', GX(row, col));
    end
    fprintf('\n');
end

%% === Encode a 1×44 message vector ===

% Define 44 6-bit binary strings (from earlier data_1), as the message
data_2 = { ...
    '001010', '110010', '010011', '100001', '001010', '100110', '010000', '101001', '101100', '101111', ...
    '011100', '000101', '001110', '111010', '001001', '110100', '100010', '111111', '000101', '011100', ...
    '000110', '111101', '000000', '110001', '110100', '110111', '000101', '011001', '010000', '110011', ...
    '011011', '111010', '001011', '010000', '001001', '001000', '110111', '100101', '100011', '001001', ...
    '110110', '100111', '010110', '100000'};

% Convert binary strings to decimal values and store in row vector M_2
M_2 = zeros(1, k_2);
for i = 1:k_2
    M_2(i) = bin2dec(data_2{i});
end
disp(M_2);

% Convert the decimal message to GF(2^6) field elements
prim_poly = 67;
GF_M_2 = gf(M_2, 6, prim_poly);
disp(GF_M_2);

%% === Encoding: C = M × G ===
encoded_2 = GF_M_2 * G_2;

% Display the encoded result (in GF format and raw numeric form)
disp('Encoded result (GF object):');
disp(encoded_2);

disp('Encoded result (raw values):');
disp(encoded_2.x);

% Output the encoded vector (raw values) 10 elements per line
encoded_x = encoded_2.x;
total_elements = length(encoded_x);
group_size = 10;

fprintf('Encoded result (10 values per line):\n');
for idx = 1:group_size:total_elements
    end_idx = min(idx + group_size - 1, total_elements);
    for j = idx:end_idx
        fprintf('%d ', encoded_x(j));
    end
    fprintf('\n');
end

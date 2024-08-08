%% LOAD DATA SET

%% NORMALIZE UTS
train_data_mixed = train_data_01;
test_data_mixed = test_data_01;

m_train = mean(train_data_mixed);
std_train = std(train_data_mixed);
normalized_train_data = (train_data_mixed - m_train)./std_train;
normalized_train_data = rmoutliers(normalized_train_data);
normalized_test_data = (test_data_mixed - m_train)./std_train;

%% NORMALIZE YP
train_data_mixed = train_data_02;
test_data_mixed = test_data_02;

m_train = mean(train_data_mixed);
std_train = std(train_data_mixed);
normalized_train_data = (train_data_mixed - m_train)./std_train;
normalized_train_data = rmoutliers(normalized_train_data);
normalized_test_data = (test_data_mixed - m_train)./std_train;

%% NORMALIZE E
train_data_mixed = train_data_03;
test_data_mixed = test_data_04;

m_train = mean(train_data_mixed);
std_train = std(train_data_mixed);
normalized_train_data = (train_data_mixed - m_train)./std_train;
normalized_train_data = rmoutliers(normalized_train_data);
normalized_test_data = (test_data_mixed - m_train)./std_train;


%% TRAINING

genOpt = genfisOptions('GridPartition');
genOpt.NumMembershipFunctions = 5;
genOpt.InputMembershipFunctionType = 'gaussmf';

inFIS = genfis(normalized_train_data(:,1:5), normalized_train_data(:,6),genOpt);
opt = anfisOptions('InitialFIS',inFIS,'EpochNumber',10);

outFIS = anfis([normalized_train_data(:,1:5) normalized_train_data(:,6)],opt);

%% TESTING + DENORMALIZE

samples = 1:50;
% m_train = m_train_E;
% std_train = std_train_E;

% outFIS = outFIS_E;

test_data_mixed = test_data_04;
normalized_test_data = (test_data_mixed - m_train)./std_train;
for i = 1:50 % nummber of samples
    output1 = evalfis(outFIS, normalized_test_data(i,1:5));
    denormalized_output(i) = ( std_train(6) * output1 ) + m_train(6);
end


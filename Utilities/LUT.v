// Lookup table for function log((1+e^(-|x|)) / (1-e^(-|x|)) )
// X: 6 bits, 2 integer: 4 fractional, thus can be sampled at 0.0625
// Y: 4 bits, 2 integer: 2 fractional, thus can be quantized at 0.25

module LUT (
  input [7-1 : 0] X,
  output reg [4-1 : 0] Y
);

  always@ (X) begin
    case (X)
      7'b0000000: Y = 4'b1111;  // f(0.0) = 3.75 ~ 3.75
      7'b0000001: Y = 4'b1000;  // f(0.25) = 2.0846309693248757 ~ 2.0
      7'b0000010: Y = 4'b0110;  // f(0.5) = 1.4068291137472952 ~ 1.5
      7'b0000011: Y = 4'b0100;  // f(0.75) = 1.0262244711552542 ~ 1.0
      7'b0000100: Y = 4'b0011;  // f(1.0) = 0.7719368329053048 ~ 0.75
      7'b0000101: Y = 4'b0010;  // f(1.25) = 0.589508646432784 ~ 0.5
      7'b0000110: Y = 4'b0010;  // f(1.5) = 0.4538957369082066 ~ 0.5
      7'b0000111: Y = 4'b0001;  // f(1.75) = 0.3511110171316341 ~ 0.25
      7'b0001000: Y = 4'b0001;  // f(2.0) = 0.2723414689118317 ~ 0.25
      7'b0001001: Y = 4'b0001;  // f(2.25) = 0.21158428010179142 ~ 0.25
      7'b0001010: Y = 4'b0001;  // f(2.5) = 0.1645402180345878 ~ 0.25
      7'b0001011: Y = 4'b0001;  // f(2.75) = 0.1280303231172332 ~ 0.25
      7'b0001100: Y = 4'b0000;  // f(3.0) = 0.09965653251644369 ~ 0.0
      7'b0001101: Y = 4'b0000;  // f(3.25) = 0.077587313867282 ~ 0.0
      7'b0001110: Y = 4'b0000;  // f(3.5) = 0.06041313452808037 ~ 0.0
      7'b0001111: Y = 4'b0000;  // f(3.75) = 0.0470441661225781 ~ 0.0
      7'b0010000: Y = 4'b0000;  // f(4.0) = 0.03663537474369636 ~ 0.0
      7'b0010001: Y = 4'b0000;  // f(4.25) = 0.028530402934517397 ~ 0.0
      7'b0010010: Y = 4'b0000;  // f(4.5) = 0.02221890711689061 ~ 0.0
      7'b0010011: Y = 4'b0000;  // f(4.75) = 0.017303822155776718 ~ 0.0
      7'b0010100: Y = 4'b0000;  // f(5.0) = 0.013476097938606508 ~ 0.0
      7'b0010101: Y = 4'b0000;  // f(5.25) = 0.010495133131970643 ~ 0.0
      7'b0010110: Y = 4'b0000;  // f(5.5) = 0.008173588381406572 ~ 0.0
      7'b0010111: Y = 4'b0000;  // f(5.75) = 0.006365583087728265 ~ 0.0
      7'b0011000: Y = 4'b0000;  // f(6.0) = 0.0049575145066898104 ~ 0.0
      7'b0011001: Y = 4'b0000;  // f(6.25) = 0.003860913068554783 ~ 0.0
      7'b0011010: Y = 4'b0000;  // f(6.5) = 0.003006880651470039 ~ 0.0
      7'b0011011: Y = 4'b0000;  // f(6.75) = 0.002341760311735284 ~ 0.0
      7'b0011100: Y = 4'b0000;  // f(7.0) = 0.001823764436613251 ~ 0.0
      7'b0011101: Y = 4'b0000;  // f(7.25) = 0.0014203490164682224 ~ 0.0
      7'b0011110: Y = 4'b0000;  // f(7.5) = 0.0011061688530888379 ~ 0.0
      7'b0011111: Y = 4'b0000;  // f(7.75) = 0.0008614851344310268 ~ 0.0
      7'b0100000: Y = 4'b0000;  // f(8.0) = 0.000670925280972407 ~ 0.0
      7'b0100001: Y = 4'b0000;  // f(8.25) = 0.0005225171264915748 ~ 0.0
      7'b0100010: Y = 4'b0000;  // f(8.5) = 0.00040693674363700874 ~ 0.0
      7'b0100011: Y = 4'b0000;  // f(8.75) = 0.00031692265288412293 ~ 0.0
      7'b0100100: Y = 4'b0000;  // f(9.0) = 0.0002468196094264098 ~ 0.0
      7'b0100101: Y = 4'b0000;  // f(9.25) = 0.00019222330471475586 ~ 0.0
      7'b0100110: Y = 4'b0000;  // f(9.5) = 0.00014970366005496292 ~ 0.0
      7'b0100111: Y = 4'b0000;  // f(9.75) = 0.00011658932759383428 ~ 0.0
      7'b0101000: Y = 4'b0000;  // f(10.0) = 9.079985958730571e-05 ~ 0.0
      7'b0101001: Y = 4'b0000;  // f(10.25) = 7.071500173041337e-05 ~ 0.0
      7'b0101010: Y = 4'b0000;  // f(10.5) = 5.507289871350473e-05 ~ 0.0
      7'b0101011: Y = 4'b0000;  // f(10.75) = 4.289081663965259e-05 ~ 0.0
      7'b0101100: Y = 4'b0000;  // f(11.0) = 3.3403401583538476e-05 ~ 0.0
      7'b0101101: Y = 4'b0000;  // f(11.25) = 2.60145953096234e-05 ~ 0.0
      7'b0101110: Y = 4'b0000;  // f(11.5) = 2.0260187197876252e-05 ~ 0.0
      7'b0101111: Y = 4'b0000;  // f(11.75) = 1.577864965483916e-05 ~ 0.0
      7'b0110000: Y = 4'b0000;  // f(12.0) = 1.2288424706844796e-05 ~ 0.0
      7'b0110001: Y = 4'b0000;  // f(12.25) = 9.570234784286784e-06 ~ 0.0
      7'b0110010: Y = 4'b0000;  // f(12.5) = 7.453306344154328e-06 ~ 0.0
      7'b0110011: Y = 4'b0000;  // f(12.75) = 5.804640817349936e-06 ~ 0.0
      7'b0110100: Y = 4'b0000;  // f(13.0) = 4.520658814032911e-06 ~ 0.0
      7'b0110101: Y = 4'b0000;  // f(13.25) = 3.5206926241672784e-06 ~ 0.0
      7'b0110110: Y = 4'b0000;  // f(13.5) = 2.74191817288693e-06 ~ 0.0
      7'b0110111: Y = 4'b0000;  // f(13.75) = 2.1354080201560868e-06 ~ 0.0
      7'b0111000: Y = 4'b0000;  // f(14.0) = 1.6630574382189508e-06 ~ 0.0
      7'b0111001: Y = 4'b0000;  // f(14.25) = 1.2951904352494061e-06 ~ 0.0
      7'b0111010: Y = 4'b0000;  // f(14.5) = 1.008695325015218e-06 ~ 0.0
      7'b0111011: Y = 4'b0000;  // f(14.75) = 7.85572709185188e-07 ~ 0.0
      7'b0111100: Y = 4'b0000;  // f(15.0) = 6.11804640979781e-07 ~ 0.0
      7'b0111101: Y = 4'b0000;  // f(15.25) = 4.7647393359265615e-07 ~ 0.0
      7'b0111110: Y = 4'b0000;  // f(15.5) = 3.710782725383919e-07 ~ 0.0
      7'b0111111: Y = 4'b0000;  // f(15.75) = 2.889960492985625e-07 ~ 0.0
      7'b1000000: Y = 4'b0000;  // f(16.0) = 2.250703494535886e-07 ~ 0.0
      7'b1000001: Y = 4'b0000;  // f(16.25) = 1.752849642797327e-07 ~ 0.0
      7'b1000010: Y = 4'b0000;  // f(16.5) = 1.3651206743603036e-07 ~ 0.0
      7'b1000011: Y = 4'b0000;  // f(16.75) = 1.0631570502802394e-07 ~ 0.0
      7'b1000100: Y = 4'b0000;  // f(17.0) = 8.279875442218305e-08 ~ 0.0
      7'b1000101: Y = 4'b0000;  // f(17.25) = 6.448373471560882e-08 ~ 0.0
      7'b1000110: Y = 4'b0000;  // f(17.5) = 5.021998313222822e-08 ~ 0.0
      7'b1000111: Y = 4'b0000;  // f(17.75) = 3.9111362050242535e-08 ~ 0.0
      7'b1001000: Y = 4'b0000;  // f(18.0) = 3.045995942380299e-08 ~ 0.0
      7'b1001001: Y = 4'b0000;  // f(18.25) = 2.372224033493611e-08 ~ 0.0
      7'b1001010: Y = 4'b0000;  // f(18.5) = 1.8474899439493738e-08 ~ 0.0
      7'b1001011: Y = 4'b0000;  // f(18.75) = 1.4388266030579954e-08 ~ 0.0
      7'b1001100: Y = 4'b0000;  // f(19.0) = 1.1205592835239931e-08 ~ 0.0
      7'b1001101: Y = 4'b0000;  // f(19.25) = 8.726924478287202e-09 ~ 0.0
      7'b1001110: Y = 4'b0000;  // f(19.5) = 6.796535755522823e-09 ~ 0.0
      7'b1001111: Y = 4'b0000;  // f(19.75) = 5.293147239828856e-09 ~ 0.0
      7'b1010000: Y = 4'b0000;  // f(20.0) = 4.1223073758387905e-09 ~ 0.0
      7'b1010001: Y = 4'b0000;  // f(20.25) = 3.2104561180169877e-09 ~ 0.0
      7'b1010010: Y = 4'b0000;  // f(20.5) = 2.5003057371015398e-09 ~ 0.0
      7'b1010011: Y = 4'b0000;  // f(20.75) = 1.9472401450086334e-09 ~ 0.0
      7'b1010100: Y = 4'b0000;  // f(21.0) = 1.5165122479612968e-09 ~ 0.0
      7'b1010101: Y = 4'b0000;  // f(21.25) = 1.1810608040139124e-09 ~ 0.0
      7'b1010110: Y = 4'b0000;  // f(21.5) = 9.198111157393239e-10 ~ 0.0
      7'b1010111: Y = 4'b0000;  // f(21.75) = 7.163496460115212e-10 ~ 0.0
      7'b1011000: Y = 4'b0000;  // f(22.0) = 5.578937310566663e-10 ~ 0.0
      7'b1011001: Y = 4'b0000;  // f(22.25) = 4.3448800103871437e-10 ~ 0.0
      7'b1011010: Y = 4'b0000;  // f(22.5) = 3.383795465477329e-10 ~ 0.0
      7'b1011011: Y = 4'b0000;  // f(22.75) = 2.635303086514754e-10 ~ 0.0
      7'b1011100: Y = 4'b0000;  // f(23.0) = 2.052376046679846e-10 ~ 0.0
      7'b1011101: Y = 4'b0000;  // f(23.25) = 1.5983925293171933e-10 ~ 0.0
      7'b1011110: Y = 4'b0000;  // f(23.5) = 1.2448309049453288e-10 ~ 0.0
      7'b1011111: Y = 4'b0000;  // f(23.75) = 9.694733904082838e-11 ~ 0.0
      7'b1100000: Y = 4'b0000;  // f(24.0) = 7.550271518822776e-11 ~ 0.0
      7'b1100001: Y = 4'b0000;  // f(24.25) = 5.880163022991305e-11 ~ 0.0
      7'b1100010: Y = 4'b0000;  // f(24.5) = 4.579470136329481e-11 ~ 0.0
      7'b1100011: Y = 4'b0000;  // f(24.75) = 3.5665026487027455e-11 ~ 0.0
      7'b1100100: Y = 4'b0000;  // f(25.0) = 2.7776003718896263e-11 ~ 0.0
      7'b1100101: Y = 4'b0000;  // f(25.25) = 2.1632029500772428e-11 ~ 0.0
      7'b1100110: Y = 4'b0000;  // f(25.5) = 1.6846968264730065e-11 ~ 0.0
      7'b1100111: Y = 4'b0000;  // f(25.75) = 1.3120615704934025e-11 ~ 0.0
      7'b1101000: Y = 4'b0000;  // f(26.0) = 1.021827067399281e-11 ~ 0.0
      7'b1101001: Y = 4'b0000;  // f(26.25) = 7.958078640481457e-12 ~ 0.0
      7'b1101010: Y = 4'b0000;  // f(26.5) = 6.197709012648268e-12 ~ 0.0
      7'b1101011: Y = 4'b0000;  // f(26.75) = 4.826805621848681e-12 ~ 0.0
      7'b1101100: Y = 4'b0000;  // f(27.0) = 3.759215161373714e-12 ~ 0.0
      7'b1101101: Y = 4'b0000;  // f(27.25) = 2.927658115932252e-12 ~ 0.0
      7'b1101110: Y = 4'b0000;  // f(27.5) = 2.2799540033676224e-12 ~ 0.0
      7'b1101111: Y = 4'b0000;  // f(27.75) = 1.7756907055838988e-12 ~ 0.0
      7'b1110000: Y = 4'b0000;  // f(28.0) = 1.3828937994721388e-12 ~ 0.0
      7'b1110001: Y = 4'b0000;  // f(28.25) = 1.076916333885822e-12 ~ 0.0
      7'b1110010: Y = 4'b0000;  // f(28.5) = 8.388845174064164e-13 ~ 0.0
      7'b1110011: Y = 4'b0000;  // f(28.75) = 6.532552276892287e-13 ~ 0.0
      7'b1110100: Y = 4'b0000;  // f(29.0) = 5.089262344880422e-13 ~ 0.0
      7'b1110101: Y = 4'b0000;  // f(29.25) = 3.961275751861774e-13 ~ 0.0
      7'b1110110: Y = 4'b0000;  // f(29.5) = 3.086420008457459e-13 ~ 0.0
      7'b1110111: Y = 4'b0000;  // f(29.75) = 2.40252262528855e-13 ~ 0.0
      7'b1111000: Y = 4'b0000;  // f(30.0) = 1.8718360195178387e-13 ~ 0.0
      7'b1111001: Y = 4'b0000;  // f(30.25) = 1.4566126083080994e-13 ~ 0.0
      7'b1111010: Y = 4'b0000;  // f(30.5) = 1.1368683772160957e-13 ~ 0.0
      7'b1111011: Y = 4'b0000;  // f(30.75) = 8.837375276015856e-14 ~ 0.0
      7'b1111100: Y = 4'b0000;  // f(31.0) = 6.883382752675733e-14 ~ 0.0
      7'b1111101: Y = 4'b0000;  // f(31.25) = 5.373479439185613e-14 ~ 0.0
      7'b1111110: Y = 4'b0000;  // f(31.5) = 4.1744385725905015e-14 ~ 0.0
      7'b1111111: Y = 4'b0000;  // f(31.75) = 3.241851231905405e-14 ~ 0.0
      default:   Y = 0;
    endcase

  end

endmodule

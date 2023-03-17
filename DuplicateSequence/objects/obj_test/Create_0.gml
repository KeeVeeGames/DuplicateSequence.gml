layer_sequence_create(layer, 400, 200, seq_test);

var seq_new = sequence_duplicate(seq_test);
seq_new.tracks[0].keyframes[0].channels[0].text = "Hello World";

layer_sequence_create(layer, 400, 400, seq_new);
layer_sequence_create(layer, room_width / 4, room_height / 2, seq_tank);

seq_tank1 = sequence_duplicate(seq_tank);
seq_tank2 = sequence_duplicate(seq_tank);

layer_sequence_create(layer, room_width / 4 * 2, room_height / 2, seq_tank1);
layer_sequence_create(layer, room_width / 4 * 3, room_height / 2, seq_tank2);

seq_tank1.tracks[3].keyframes[0].channels[0].text = "Level 1";
seq_tank1.tracks[2].keyframes[0].channels[0].spriteIndex = spr_tank_body_1;
seq_tank1.tracks[1].keyframes[0].channels[0].spriteIndex = spr_tank_turret_1;
seq_tank1.tracks[0].keyframes[0].channels[0].spriteIndex = spr_tank_tracks_1;

seq_tank2.tracks[3].keyframes[0].channels[0].text = "Level 99";
seq_tank2.tracks[2].keyframes[0].channels[0].spriteIndex = spr_tank_body_2;
seq_tank2.tracks[1].keyframes[0].channels[0].spriteIndex = spr_tank_turret_2;
seq_tank2.tracks[0].keyframes[0].channels[0].spriteIndex = spr_tank_tracks_2;
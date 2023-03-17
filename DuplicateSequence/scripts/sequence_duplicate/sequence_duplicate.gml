function sequence_duplicate(sequence_struct_or_id/*:Sequence|sequence|asset_sequence*/)/*->sequence*/ {
    var sequence_orig/*:Sequence*/;
    
    if (is_real(sequence_struct_or_id)) {
        sequence_orig = sequence_get(sequence_struct_or_id);
    } else {
        sequence_orig = sequence_struct_or_id /*#as Sequence*/;
    }
    
    var sequence_new/*:Sequence*/ = sequence_create();
    
    sequence_new.name                   = sequence_orig.name;
    sequence_new.loopmode               = sequence_orig.loopmode;
    sequence_new.playbackSpeed          = sequence_orig.playbackSpeed;
    sequence_new.playbackSpeedType      = sequence_orig.playbackSpeedType;
    sequence_new.length                 = sequence_orig.length;
    sequence_new.volume                 = sequence_orig.volume;
    sequence_new.xorigin                = sequence_orig.xorigin;
    sequence_new.yorigin                = sequence_orig.yorigin;
    sequence_new.messageEventKeyframes  = sequence_keyframes_duplicate(sequence_orig.messageEventKeyframes, seqtracktype_message);
    sequence_new.momentKeyframes        = sequence_keyframes_duplicate(sequence_orig.momentKeyframes, seqtracktype_moment);
    sequence_new.tracks                 = sequence_tracks_duplicate(sequence_orig.tracks);
    
    return /*#cast*/ sequence_new /*#as sequence*/;
}

function sequence_keyframes_duplicate(keyframes/*:Keyframe[]*/, type/*:seqtracktype*/)/*->Keyframe[]*/ {
    var keyframes_length = array_length(keyframes);
    var keyframes_new/*:Keyframe[]*/ = array_create(keyframes_length);
    
    for (var i = 0; i < keyframes_length; i++) {
        keyframes_new[i] = sequence_keyframe_duplicate(keyframes[i], type);
    }
    
    return keyframes_new;
}

function sequence_keyframe_duplicate(keyframe_struct/*:Keyframe*/, type/*:seqtracktype*/)/*->Keyframe*/ {
    var keyframe_new/*:Keyframe*/ = sequence_keyframe_new(type);
    
    keyframe_new.frame      = keyframe_struct.frame;
    keyframe_new.length     = keyframe_struct.length;
    keyframe_new.stretch    = keyframe_struct.stretch;
    keyframe_new.channels   = sequence_keyframedatas_duplicate(keyframe_struct.channels, type);
    
    return keyframe_new;
}

function sequence_keyframedatas_duplicate(keyframedatas/*:KeyframeData[]*/, type/*:seqtracktype*/)/*->KeyframeData[]*/ {
    var keyframedatas_length = array_length(keyframedatas);
    var keyframedatas_new/*:KeyframeData[]*/ = array_create(keyframedatas_length);
    
    for (var i = 0; i < keyframedatas_length; i++) {
        keyframedatas_new[i] = sequence_keyframedata_duplicate(keyframedatas[i], type);
    }
    
    return keyframedatas_new;
}

function sequence_keyframedata_duplicate(keyframedata_struct/*:KeyframeData*/, type/*:seqtracktype*/)/*->KeyframeData*/ {
    var keyframedata_new/*:KeyframeData*/ = sequence_keyframedata_new(type);
    
    keyframedata_new.channel = keyframedata_struct.channel;
    
    switch (type) {
        case seqtracktype_graphic:
            keyframedata_new.spriteIndex = keyframedata_struct.spriteIndex;
            
            break;
            
        case seqtracktype_audio:
            keyframedata_new.soundIndex = keyframedata_struct.soundIndex;
            keyframedata_new.playbackMode = keyframedata_struct.playbackMode;
            
            break;
            
        case seqtracktype_real:
            if (keyframedata_new.curve == -1) {
                keyframedata_new.value = keyframedata_struct.value;
            } else {
                keyframedata_new.curve = keyframedata_struct.curve;     // TODO: Implement duplicating curves
            }
            
            break;
            
        case seqtracktype_color:
            keyframedata_new.color = array_create(4);
            
            for (var i = 0; i < 4; i++) {
                keyframedata_new.color[i] = keyframedata_struct.color[i];
            }
            
            break;
            
        case seqtracktype_sequence:
            keyframedata_new.sequence = sequence_duplicate(keyframedata_struct.sequence);
            
            break;
            
        case seqtracktype_instance:
            keyframedata_new.objectIndex = keyframedata_struct.objectIndex;
            
            break;
            
        case seqtracktype_message:
            var events_length = array_length(keyframedata_struct.events);
            keyframedata_new.events = array_create(events_length);
            
            for (var i = 0; i < 4; i++) {
                keyframedata_new.events[i] = keyframedata_struct.events[i];
            }
            
            break;
            
        case seqtracktype_moment:
            keyframedata_new.event = keyframedata_struct.event;
            
            break;
            
        case seqtracktype_text:
            keyframedata_new.text = keyframedata_struct.text;
            keyframedata_new.wrap = keyframedata_struct.wrap;
            keyframedata_new.alignmentH = keyframedata_struct.alignmentH;
            keyframedata_new.alignmentV = keyframedata_struct.alignmentV;
            keyframedata_new.fontIndex = keyframedata_struct.fontIndex;
            
            break;
    }
    
    return keyframedata_new;
}

function sequence_tracks_duplicate(tracks/*:Track[]*/)/*->Track[]*/ {
    var tracks_length = array_length(tracks);
    var tracks_new/*:Track[]*/ = array_create(tracks_length);
    
    for (var i = 0; i < tracks_length; i++) {
        tracks_new[i] = sequence_track_duplicate(tracks[i]);
    }
    
    return tracks_new;
}

function sequence_track_duplicate(track_struct/*:Track*/)/*->Track*/ {
    var track_new/*:Track*/ = sequence_track_new(track_struct.type);
    
    track_new.name          = track_struct.name;
    track_new.tracks        = sequence_tracks_duplicate(track_struct.tracks);
    track_new.visible       = track_struct.visible;
    track_new.keyframes     = sequence_keyframes_duplicate(track_struct.keyframes, track_new.type);
    
    // interpolation field GameMaker bug
    if (variable_struct_exists(track_struct, "interpolation")) {
		track_new.interpolation = track_struct.interpolation;
	} else {
        track_new.interpolation = true;
	}
    
    return track_new;
}

/// @hint KeyframeData
/// @hint KeyframeData implements KeyChannel
/// @hint KeyframeData implements GraphicTrack
/// @hint KeyframeData implements SequenceTrack
/// @hint KeyframeData implements AudioTrack
/// @hint KeyframeData implements SpriteTrack
/// @hint KeyframeData implements BoolTrack
/// @hint KeyframeData implements StringTrack
/// @hint KeyframeData implements ColorTrack
/// @hint KeyframeData implements RealTrack
/// @hint KeyframeData implements InstanceTrack
/// @hint KeyframeData implements TextTrack
/// @hint KeyframeData implements MessageEvent
/// @hint KeyframeData implements Moment
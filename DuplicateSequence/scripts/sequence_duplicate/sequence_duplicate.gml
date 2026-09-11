/// @pure
/// @param {Asset.GMSequence|Struct.Sequence} sequence_struct_or_id     The sequence index from the asset browser or sequence object struct.
/// @returns {Struct.Sequence}
/// @description                                                        This function will return a new sequence struct that is a deep copy of the source sequence.
function sequence_duplicate(sequence_struct_or_id/*:sequence|sequence_object*/)/*->sequence_object*/ {
    /// @hint sequence_duplicate(sequence_struct_or_id:sequence|sequence_object)->sequence_object
    
    var sequence_orig/*:sequence_object*/;
    
    if (!is_struct(sequence_struct_or_id)) {
        sequence_orig = sequence_get(sequence_struct_or_id /*#as sequence*/);
    } else {
        sequence_orig = sequence_struct_or_id /*#as sequence_object*/;
    }
    
    var sequence_new/*:sequence_object*/ = sequence_create();
    
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
    sequence_new.tracks                 = sequence_tracks_duplicate(os_browser == browser_not_a_browser ? array_reverse(sequence_orig.tracks) : sequence_orig.tracks);
    
    return sequence_new;
}

/// @pure
/// @param {Array<Struct.Keyframe>} keyframes       The source array that holds keyframe structs of a sequence.
/// @param {Constant.SequenceTrackType} type        The type of track that keyframes are applied to, a seqtracktype constant.
/// @returns {Array<Struct.Keyframe>}
/// @description                                    This function will return a new array of keyframes with deep copies of source keyframes.
function sequence_keyframes_duplicate(keyframes/*:sequence_keyframe[]*/, type/*:sequence_track_type*/)/*->sequence_keyframe[]*/ {
    /// @hint sequence_keyframes_duplicate(keyframes:sequence_keyframe[], type:sequence_track_type)->sequence_keyframe[]
    
    var keyframes_length = array_length(keyframes);
    var keyframes_new/*:sequence_keyframe[]*/ = array_create(keyframes_length);
    
    for (var i = 0; i < keyframes_length; i++) {
        keyframes_new[i] = sequence_keyframe_duplicate(keyframes[i], type);
    }
    
    return keyframes_new;
}

/// @pure
/// @param {Struct.Keyframe} keyframe_struct        The track keyframe struct to duplicate.
/// @param {Constant.SequenceTrackType} type        The type of track that the keyframe is applied to, a seqtracktype constant.
/// @returns {Struct.Keyframe}
/// @description                                    This function will return a new keyframe struct that is a deep copy of the source sequence keyframe.
function sequence_keyframe_duplicate(keyframe_struct/*:sequence_keyframe*/, type/*:sequence_track_type*/)/*->sequence_keyframe*/ {
    /// @hint sequence_keyframe_duplicate(keyframe_struct:sequence_keyframe, type:sequence_track_type)->sequence_keyframe
    
    var keyframe_new/*:sequence_keyframe*/ = sequence_keyframe_new(type);
    
    keyframe_new.frame      = keyframe_struct.frame;
    keyframe_new.length     = keyframe_struct.length;
    keyframe_new.stretch    = keyframe_struct.stretch;
    keyframe_new.channels   = sequence_keyframedatas_duplicate(keyframe_struct.channels, type);
    
    return keyframe_new;
}

/// @pure
/// @param {Array<Struct.KeyframeData>} keyframedatas       The source array that holds keyframe data structs of a sequence.
/// @param {Constant.SequenceTrackType} type                The type of track that keyframes are applied to, a seqtracktype constant.
/// @returns {Array<Struct.KeyframeData>}
/// @description                                            This function will return a new array of keyframe data with a deep copy of the source keyframe data.
function sequence_keyframedatas_duplicate(keyframedatas/*:sequence_keyframe_data[]*/, type/*:sequence_track_type*/)/*->sequence_keyframe_data[]*/ {
    /// @hint sequence_keyframedatas_duplicate(keyframedatas:sequence_keyframe_data[], type:sequence_track_type)->sequence_keyframe_data[]
    
    var keyframedatas_length = array_length(keyframedatas);
    var keyframedatas_new/*:sequence_keyframe_data[]*/ = array_create(keyframedatas_length);
    
    for (var i = 0; i < keyframedatas_length; i++) {
        keyframedatas_new[i] = sequence_keyframedata_duplicate(keyframedatas[i], type);
    }
    
    return keyframedatas_new;
}

/// @pure
/// @param {Struct.KeyframeData} keyframedata_struct        The keyframe data struct to duplicate.
/// @param {Constant.SequenceTrackType} type                The type of track that the keyframe is applied to, a seqtracktype constant.
/// @returns {Struct.KeyframeData}
/// @description                                            This function will return a new keyframe data struct that is a deep copy of the source keyframe data struct.
function sequence_keyframedata_duplicate(keyframedata_struct/*:sequence_keyframe_data*/, type/*:sequence_track_type*/)/*->sequence_keyframe_data*/ {
    /// @hint sequence_keyframedata_duplicate(keyframedata_struct:sequence_keyframe_data, type:sequence_track_type)->sequence_keyframe_data
    
    var keyframedata_new/*:sequence_keyframe_data*/ = sequence_keyframedata_new(type);
    
    keyframedata_new.channel = keyframedata_struct.channel;
    
    switch (type) {
        case seqtracktype_graphic:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_graphic*/).spriteIndex = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_graphic*/).spriteIndex;
            
            break;
            
        case seqtracktype_audio:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_audiosequence_keyframe_data_audio*/).soundIndex = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_audio*/).soundIndex;
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_audio*/).playbackMode = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_audio*/).playbackMode;
            
            break;
            
        case seqtracktype_real:
            if ((/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_real*/).curve == -1) {
                (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_real*/).value = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_real*/).value;
            } else {
                (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_real*/).curve = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_real*/).curve;     // TODO: Implement duplicating curves
            }
            
            break;
            
        case seqtracktype_color:
            var color/*:int[]*/ = array_create(4);
            
            for (var i = 0; i < 4; i++) {
                color[i] = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_color*/).color[i];
            }
            
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_color*/).color = color;
            
            break;
            
        case seqtracktype_colour:
            var colour/*:int[]*/ = array_create(4);     // correct spelling!!
            
            for (var i = 0; i < 4; i++) {
                colour[i] = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_colour*/).colour[i];
            }
            
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_colour*/).colour = colour;
            
            break;
            
        case seqtracktype_bool:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_bool*/).value = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_bool*/).value;
            
            break;
            
        case seqtracktype_string:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_string*/).value = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_string*/).value;
            
            break;
            
        case seqtracktype_sequence:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_sequence*/).sequence = /*#cast*/ sequence_duplicate((/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_sequence*/).sequence);
            
            break;
            
        case seqtracktype_instance:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_instance*/).objectIndex = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_instance*/).objectIndex;
            
            break;
            
        case seqtracktype_message:
            var events_length = array_length((/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_message*/).events);
            var events = array_create(events_length);
            
            for (var i = 0; i < events_length; i++) {
                events[i] = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_message*/).events[i];
            }
            
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_message*/).events = events;
            
            break;
            
        case seqtracktype_moment:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_moment*/).event = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_moment*/).event;
            
            break;
            
        case seqtracktype_text:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_text*/).text = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_text*/).text;
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_text*/).wrap = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_text*/).wrap;
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_text*/).alignmentH = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_text*/).alignmentH;
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_text*/).alignmentV = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_text*/).alignmentV;
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_text*/).fontIndex = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_text*/).fontIndex;
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_text*/).origin = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_text*/).origin;
            
            break;
            
        case seqtracktype_particlesystem:
            (/*#cast*/ keyframedata_new /*#as sequence_keyframe_data_particlesystem*/).particleSystemIndex = (/*#cast*/ keyframedata_struct /*#as sequence_keyframe_data_particlesystem*/).particleSystemIndex;
            
            break;
            
        default:
            show_debug_message($"[sequence_duplicate] Warning! Unknown track type {type}");
    }
    
    return keyframedata_new;
}

/// @pure
/// @param {Array<Struct.Track>} tracks             The source array that holds track structs of a sequence.
/// @returns {Array<Struct.Track>}
/// @description                                    This function will return a new array of tracks with a deep copy of the source tracks.
function sequence_tracks_duplicate(tracks/*:sequence_track[]*/)/*->sequence_track[]*/ {
    /// @hint sequence_tracks_duplicate(tracks:sequence_track[])->sequence_track[]
    
    var tracks_length = array_length(tracks);
    var tracks_new/*:sequence_track[]*/ = array_create(tracks_length);
    
    for (var i = 0; i < tracks_length; i++) {
        tracks_new[i] = sequence_track_duplicate(tracks[i]);
    }
    
    return tracks_new;
}

/// @pure
/// @param {Struct.Track} track_struct              The track struct to duplicate.
/// @returns {Struct.Track}
/// @description                                    This function will return a new track struct that is a deep copy of the source track struct.
function sequence_track_duplicate(track_struct/*:sequence_track*/)/*->sequence_track*/ {
    /// @hint sequence_track_duplicate(track_struct:sequence_track)->sequence_track
    
    var track_new/*:sequence_track*/ = sequence_track_new(track_struct.type);
    
    track_new.name          = track_struct.name;
    track_new.tracks        = sequence_tracks_duplicate(track_struct.tracks);
    track_new.visible       = track_struct.visible;
    
    if (track_struct.keyframes != -1) {
        track_new.keyframes = sequence_keyframes_duplicate(track_struct.keyframes, track_new.type);
    }
    
    // interpolation field GameMaker bug fix
    if (variable_struct_exists(track_struct, "interpolation")) {
        track_new.interpolation = track_struct.interpolation;
    }
    
    return track_new;
}

/// @pure
/// @param {Asset.GMSequence|Struct.Sequence} sequence_struct_or_id     The sequence index from the asset browser or sequence object struct.
/// @returns {Bool}
/// @description                                                        This function will check the sequence for errors, print any errors to the Output, and return false if any are found; otherwise, will return true.
function sequence_validate(sequence_struct_or_id/*:sequence|sequence_object*/)/*->bool*/ {
    /// @hint sequence_validate(sequence_struct_or_id:sequence|sequence_object)->bool
    
    var sequence_orig/*:sequence_object*/;
    
    if (!is_struct(sequence_struct_or_id)) {
        sequence_orig = sequence_get(sequence_struct_or_id /*#as sequence*/);
    } else {
        sequence_orig = sequence_struct_or_id /*#as sequence_object*/;
    }
    
    return sequence_tracks_validate($"[{sequence_orig.name}]", sequence_orig.tracks);
}

/// @pure
/// @param {Array<Struct.Track>} tracks             The source array that holds track structs of a sequence.
/// @returns {Array<Struct.Track>}
/// @description                                    This function will check the sequence tracks for errors, print any errors to the Output, and return false if any are found; otherwise, will return true.
function sequence_tracks_validate(route/*:string*/, tracks/*:sequence_track[]*/)/*->bool*/ {
    /// @hint sequence_tracks_validate(route:string, tracks:sequence_track[])->bool
    
    var tracks_length = array_length(tracks);
    var names_seen = {};
    var result = true;
    
    for (var i = 0; i < tracks_length; i++) {
        var track = tracks[i];
        var name = track.name;
        var hash = variable_get_hash(name);
        
        if (struct_exists_from_hash(names_seen, hash)) {
            show_debug_message($"[sequence_duplicate] Validation: duplicate track found in {route}! Track [{name}] is present more than once; expect unstable behaviour. Check the .yy file of the original sequence and remove the incorrect duplicate track.");
            result = false;
        } else {
            struct_set_from_hash(names_seen, hash, name);
        }
        
        if (sequence_tracks_validate($"{route}:[{track.name}]", track.tracks) == false) {
            result = false;
        }
    }
    
    return result;
}
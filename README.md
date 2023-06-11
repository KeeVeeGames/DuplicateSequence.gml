# DuplicateSequence.gml

[![Donate](https://img.shields.io/badge/donate-%E2%9D%A4-blue.svg)](https://musnik.itch.io/donate-me) [![License](https://img.shields.io/github/license/KeeVeeGames/DuplicateSequence.gml)](#!)

This is a collection of scripts providing a simple way to deep copy sequences and sequence fields in your GameMaker projects. Deep copying ensures that a new independent copy of a sequence is created, allowing you to modify and manipulate the copy without affecting the original sequence. It allows you to copy sequences itself, as well as keyframes, keyframe data and tracks separately.

One of the use cases of modifying sequences in runtime is, for example, creating a layout for UI button / resource art / character animation with placeholder images and text in the IDE, and then changing it with the final ones for each instance before sending them on screen.

In GameMaker currently, there is no built-in way to modify sequences in runtime without modifying the main sequence resource. This function is aimed to fix this issue, so you can create a duplicate of your sequence resource, modify its properties and spawn a new sequence instance without breaking the original one. This also may be useful for serialization purposes.

## Installation:

Copy the [script](https://github.com/KeeVeeGames/DuplicateSequence.gml/blob/main/DuplicateSequence/scripts/sequence_duplicate/sequence_duplicate.gml) into your project.   
Or get the latest asset package from the [releases page](../../releases) and import it into IDE.

## Example:

```js
layer_sequence_create(layer, 400, 200, seq_test);                   // place original sequence in game

var seq_new = sequence_duplicate(seq_test);                         // create sequence duplicate
seq_new.tracks[0].keyframes[0].channels[0].text = "Hello World";    // change new sequence's property
// this will not change the original sequence property!

layer_sequence_create(layer, 400, 400, seq_new);                    // place new sequence in game
```

## Reference:

### `sequence_duplicate(sequence_struct_or_id)` ➞ `Struct.Sequence`
This function will return a new sequence struct that is a deep copy of the source sequence.

**Parameters:**
| **Name**              | **Type**                                | **Description**                                                     |
|-----------------------|-----------------------------------------|---------------------------------------------------------------------|
| sequence_struct_or_id | `Asset.GMSequence` or `Struct.Sequence` | The sequence index from the asset browser or sequence object struct |

**Returns:** `Struct.Sequence`
## 

### `sequence_keyframes_duplicate(keyframes, type)` ➞ `Struct.Keyframe[]`
This function will return a new array of keyframes with deep copies of source keyframes.

**Parameters:**
| **Name**  | **Type**                     | **Description**                                                          |
|-----------|------------------------------|--------------------------------------------------------------------------|
| keyframes | `Struct.Keyframe[]`          | The source array that holds keyframe structs of a sequence               |
| type      | `Constant.SequenceTrackType` | The type of track that keyframes are applied to, a seqtracktype constant |

**Returns:** `Struct.Keyframe[]`
## 

### `sequence_keyframe_duplicate(keyframe_struct, type)` ➞ `Struct.Keyframe`
This function will return a new keyframe struct that is a deep copy of the source sequence keyframe.

**Parameters:**
| **Name**        | **Type**                     | **Description**                                                            |
|-----------------|------------------------------|----------------------------------------------------------------------------|
| keyframe_struct | `Struct.Keyframe`            | The track keyframe struct to duplicate                                     |
| type            | `Constant.SequenceTrackType` | The type of track that the keyframe is applied to, a seqtracktype constant |

**Returns:** `Struct.Keyframe`
## 

### `sequence_keyframedatas_duplicate(keyframedatas, type)` ➞ `Struct.KeyframeData[]`
This function will return a new array of keyframe data with a deep copy of the source keyframe data

**Parameters:**
| **Name**      | **Type**                     | **Description**                                                            |
|---------------|------------------------------|----------------------------------------------------------------------------|
| keyframedatas | `Struct.KeyframeData[]`      | The source array that holds keyframe data structs of a sequence            |
| type          | `Constant.SequenceTrackType` | The type of track that the keyframe is applied to, a seqtracktype constant |

**Returns:** `Struct.KeyframeData[]`
## 

### `sequence_keyframedata_duplicate(keyframedata_struct, type)` ➞ `Struct.KeyframeData`
This function will return a new keyframe data struct that is a deep copy of the source keyframe data struct.

**Parameters:**
| **Name**            | **Type**                     | **Description**                                                            |
|---------------------|------------------------------|----------------------------------------------------------------------------|
| keyframedata_struct | `Struct.KeyframeData`        | The keyframe data struct to duplicate                                      |
| type                | `Constant.SequenceTrackType` | The type of track that the keyframe is applied to, a seqtracktype constant |

**Returns:** `Struct.KeyframeData`
## 

### `sequence_tracks_duplicate(tracks)` ➞ `Struct.Track[]`
This function will return a new array of tracks with a deep copy of the source tracks.

**Parameters:**
| **Name** | **Type**                     | **Description**                                                            |
|----------|------------------------------|----------------------------------------------------------------------------|
| tracks   | `Struct.Track[]`             | The source array that holds track structs of a sequence                    |

**Returns:** `Struct.Track[]`
## 

### `sequence_track_duplicate(track_struct)` ➞ `Struct.Track`
This function will return a new track struct that is a deep copy of the source track struct.

**Parameters:**
| **Name**     | **Type**                     | **Description**                                                            |
|--------------|------------------------------|----------------------------------------------------------------------------|
| track_struct | `Struct.Track`               | The track struct to duplicate                                              |

**Returns:** `Struct.Track`

## Authors:
Nikita Musatov - [MusNik / KeeVee Games](https://twitter.com/keeveegames)

**Contributors**:
* Peter - [phyrexkid](https://github.com/phyrexkid)

**License**: [MIT](https://en.wikipedia.org/wiki/MIT_License)

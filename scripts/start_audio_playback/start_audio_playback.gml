/// @description  Create buffers and start audio playback


// Create an array to store our playback data
data = array_create(ePlayback.max_size);


// First create the binary buffers we'll be playing back (and will need to fill)
if( DEBUG ) show_debug_message("create buffers....");
var audio_buffer=array_create(MAX_AUDIO_BUFFERS);
for(var i=0;i<MAX_AUDIO_BUFFERS;i++)
{
    audio_buffer[i] = buffer_create(AUDIO_BUFFER_SIZE*SAMPLE_SIZE*2, buffer_fixed, 1);
}



// Next create an audio "queue"
if( DEBUG ) show_debug_message("queuing....");
var audio_queue = audio_create_play_queue(SAMPLE_TYPE,AUDIO_SAMPLE_RATE, audio_stereo);

// Now queue up the binary buffers into our new queue
for (var i = 0; i < MAX_AUDIO_BUFFERS; i++)
{
    audio_queue_sound(audio_queue, audio_buffer[i], 0, AUDIO_BUFFER_SIZE*SAMPLE_SIZE*2);
}


// Now set these empty buffers playing, then all work is done via the audio async callback
var audio_play_index = audio_play_sound(audio_queue, 0, true);
if( DEBUG ) show_debug_message("queuing.... - done");



data[ePlayback.audio_play_index] = audio_play_index;
data[ePlayback.audio_buffer] = audio_buffer;
data[ePlayback.audio_queue] = audio_queue;
data[ePlayback.audio_type] = 0;				// type of noise to fill the buffer with (0=quiet)
data[ePlayback.audio_time] = 0;				// simple "time" step for buffer filling


return data;

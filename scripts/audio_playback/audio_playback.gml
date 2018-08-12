/// @description  _mod_audio_event(_handle)
/// @param data the array holding our data

if( !is_array(argument0) ) return;
var _data = argument0;


// now stream dynamic buffers
var audio_play_index = _data[ ePlayback.audio_play_index ];
var audio_buffer = _data[ ePlayback.audio_buffer ];
var audio_queue = _data[ ePlayback.audio_queue ];

var queue = async_load[? "queue_id"];
var num = 0;
if queue = audio_queue
{
    // Find the buffer that has just finished so that we can fill it, and then requeue it.
    for (var i = 0; i < MAX_AUDIO_BUFFERS; i++;)
    {
        var buff = audio_buffer[i];
        if async_load[? "buffer_id"] == buff
        {
			
            // Refill this buffer with more (new) audio data - remember this is STEREO, left then right data is needed
            var j=0,b=0;
			var play_type = _data[ ePlayback.audio_type ];
            while(j<AUDIO_BUFFER_SIZE)
			{
				var s = 0;
				switch(play_type)
				{
					// QUITE - no playback
					case 0:	s=0;					
							break;
						
					// NOISE playback
					case 1: s = irandom(32768);		
							break;
							
					// SQUARE wave playback
					case 2: var s = _data[ ePlayback.audio_time ]+1;
							_data[@ ePlayback.audio_time ] = s;
							s = (s & 63);
							if( s<32 ) s=0; else s = 32767;
							break;
						
					// SIN wave playback
					case 3: var s = _data[ ePlayback.audio_time ]+1;
							_data[@ ePlayback.audio_time ] = s;
							s = (s &127);
							s = 360*(s/127);
							s = dsin(s)*32768;
							break;
							

					// SAWTOOTH wave playback
					case 4: var s = _data[ ePlayback.audio_time ]+1;
							_data[@ ePlayback.audio_time ] = s;
							s = (s & 0xff);
							s = 32768*(s/0xff);
							break;

				}
				
				// Store sample value into buffer
				buffer_poke(buff,b, SAMPLE_TYPE, s);			// left channel				
                b+=SAMPLE_SIZE;
				buffer_poke(buff,b, SAMPLE_TYPE, s);			// right channel
                b+=SAMPLE_SIZE;
				j++;
            }
            
             
            // Requeue this buffer
            audio_queue_sound(audio_queue, buff, 0, AUDIO_BUFFER_SIZE*SAMPLE_SIZE*2); 
            num = j;
			break;
        }
    }    

    // Check to see if audio has stopped, and if so...restart it!
	// This can happen if you drag the window around for a bit
    if( !audio_is_playing(audio_play_index) ){
        audio_play_index = audio_play_sound(audio_queue, 0, true);
        _data[@ ePlayback.audio_play_index ] = audio_play_index;
    }
}







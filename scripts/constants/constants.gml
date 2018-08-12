#macro	DEBUG				true
#macro	GAME_FPS			60
#macro	SAMPLE_TYPE			buffer_s16
#macro	SAMPLE_SIZE			2
#macro	MAX_AUDIO_BUFFERS	8
#macro	AUDIO_SAMPLE_RATE	44100
#macro	AUDIO_BUFFER_SIZE	(AUDIO_SAMPLE_RATE/GAME_FPS)


enum ePlayback{
	audio_buffer,
	audio_queue,
	audio_play_index,
	mix_buffers,
	audio_type,
	audio_time,
	
	max_size
};



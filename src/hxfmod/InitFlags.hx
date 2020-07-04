package hxfmod;

enum abstract InitFlags(Int) from Int to Int
{
    /**
     * Initialize normally
     */
    var Normal = 0x00000000;

    /**
     * No stream thread is created internally. Streams are driven from System::update. Mainly used with non-realtime outputs.
     */
    var StreamFromUpdate = 0x00000001;

    /**
     * No mixer thread is created internally.
     * Mixing is driven from `System::update`.
     * Only applies to polling based output modes such as `FMOD_OUTPUTTYPE_NOSOUND`, `FMOD_OUTPUTTYPE_WAVWRITER`.
     */
    var MixFromUpdate = 0x00000002;

    /**
     * 3D calculations will be performed in right-handed coordinates.
     */
    var RightHand3D = 0x00000004;

    /**
     * Enables usage of `ChannelControl::setLowPassGain`, `ChannelControl::set3DOcclusion`, or automatic usage by the Geometry API.
     * All voices will add a software lowpass filter effect into the DSP chain which is idle unless one of the previous functions/features are used.
     */
    var ChannelLowpass = 0x00000100;

    /**
     * All FMOD_3D based voices will add a software lowpass and highpass filter effect into the DSP chain which will act as a distance-automated bandpass filter.
     * Use `System::setAdvancedSettings` to adjust the center frequency.
     */
    var ChannelDistanceFilter = 0x00000200;

    /**
     * Enable TCP/IP based host which allows FMOD Studio or FMOD Profiler to connect to it, and view memory, CPU and the DSP network graph in real-time.
     */
    var ProfileEnable = 0x00010000;

    /**
     * Any sounds that are 0 volume will go virtual and not be processed except for having their positions updated virtually.
     * Use `System::setAdvancedSettings` to adjust what volume besides zero to switch to virtual at.
     */
    var Vol0BecomesVirtual = 0x00020000;

    /**
     * With the geometry engine, only process the closest polygon rather than accumulating all polygons the sound to listener line intersects.
     */
    var GeometryUseClosest = 0x00040000;

    /**
     * When using `FMOD_SPEAKERMODE_5POINT1` with a stereo output device, use the Dolby Pro Logic II downmix algorithm instead of the default stereo downmix algorithm.
     */
    var PreferDolbyDownmix = 0x00080000;

    /**
     * Disables thread safety for API calls. Only use this if FMOD is being called from a single thread, and if Studio API is not being used!
     */
    var ThreadUnsafe = 0x00100000;

    /**
     * Slower, but adds level metering for every single DSP unit in the graph.
     * Use `DSP::setMeteringEnabled` to turn meters off individually. Setting this flag implies `FMOD_INIT_PROFILE_ENABLE`.
     */
    var ProfileMeterAll = 0x00200000;

    /**
     * Enables memory allocation tracking.
     * Currently this is only useful when using the Studio API.
     * Increases memory footprint and reduces performance.
     * This flag is implied by `FMOD_STUDIO_INIT_MEMORY_TRACKING`.
     */
    var MemoryTracking = 0x00400000;
}
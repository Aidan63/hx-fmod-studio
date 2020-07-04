package hxfmod.studio;

enum abstract StudioStopMode(Int) to Int
{
    /**
     * Allows AHDSR modulators to complete their release, and DSP effect tails to play out.
     */
    var AllowFadeOut;

    /**
     * Stops the event instance immediately.
     */
    var Immediate;
}
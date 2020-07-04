package hxfmod.studio;

enum abstract StudioLoadMemoryMode(Int) to Int
{
    /**
     * Memory buffer is copied internally.
     */
    var Copy;

    /**
     * Memory buffer is used directly in user memory.
     */
    var Point;
}
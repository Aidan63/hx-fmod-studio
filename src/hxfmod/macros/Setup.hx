package hxfmod.macros;

import haxe.macro.Context;
import haxe.macro.Expr.Field;

class Setup
{
    public static macro function touch() : Array<Field>
    {
        final fields = Context.getBuildFields();

        fields.push({
            name   : '__touch',
            pos    : Context.currentPos(),
            doc    : null,
            meta   : [],
            access : [ APrivate, AStatic, AInline ],
            kind   : FVar(macro : String, macro $v{ Std.string(Date.now().getTime()) })
        });

        return fields;
    }

    public static macro function xml() : Array<Field>
    {
        final pos           = Context.currentPos();
        final clazz         = Context.getLocalClass();
        final defines       = Context.getDefines();
        final fmodInc       = defines.get('fmod_inc');
        final fmodLib       = defines.get('fmod_lib');
        final fmodStudioInc = defines.get('fmod_studio_inc');
        final fmodStudioLib = defines.get('fmod_studio_lib');
        final buildXml = '<files id="haxe">
        <compilerflag value="-I$fmodInc"/>
        <compilerflag value="-I$fmodStudioInc"/>
    </files>
    <target id="haxe">
        <lib name="$fmodStudioLib"/>
    </target>';

        clazz.get().meta.add(":buildXml", [{ expr : EConst(CString(buildXml)), pos : pos }], pos);

        return Context.getBuildFields();
    }
}
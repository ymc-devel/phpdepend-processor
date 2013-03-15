<!--
    phpdepend-processor

    Makes PHPDepend code metrics readable

    @author     Frank Neff <frank.neff@ymc.ch>
    @since      2013-03-15
    @license    MIT (see license.md)
    @source     https://github.com/ymc-devel/phpdepend-processor
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="no"/>

    <xsl:template match="/JDepend">
        <xsl:apply-templates select="Cycles/Package"/>

    </xsl:template>

    <xsl:template match="Cycles/Package">
        Cycle involving
        <xsl:value-of select="@Name"/>

    </xsl:template>
</xsl:stylesheet>
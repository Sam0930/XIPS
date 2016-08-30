<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema"
   xmlns:msxsl="urn:schemas-microsoft-com:xslt">
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
      omit-xml-declaration="yes"
      indent="yes"
      standalone="yes" />
  <xsl:template match="/">
    <xsl:for-each select="Sequences">
      <xsl:element name="Sequences">
        <xsl:for-each select="Sequence">
          <xsl:element name="Sequence">
            <xsl:attribute name="ID">
              <xsl:value-of select="@ID"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
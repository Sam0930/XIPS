<?xml version="1.0"?>
  <!--
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
  
<xsl:template match ="/">
    <PrintMethods>
      <xsl:apply-templates select ="//PrintMethod"/>
    </PrintMethods>
  </xsl:template>
  <xsl:template match ="//PrintMethod">
    <PrintMethod>
      <xsl:attribute name="ID">
        <xsl:value-of select="ID"/>
      </xsl:attribute>
      <xsl:attribute name="Method">
        <xsl:value-of select="Method"/>
      </xsl:attribute>
    </PrintMethod>
  </xsl:template>
 </xsl:stylesheet> 
  -->
  
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
    <xsl:for-each select="PrintMethods">
      <xsl:element name="PrintMethods">
        <xsl:for-each select="PrintMethod">
          <xsl:element name="PrintMethod">
            <xsl:attribute name="Value">
              <xsl:value-of select="@Value"/>
            </xsl:attribute>
            <xsl:attribute name="ID">
              <xsl:value-of select="ID"/>
            </xsl:attribute>
            <xsl:attribute name="Method">
              <xsl:value-of select="Method"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
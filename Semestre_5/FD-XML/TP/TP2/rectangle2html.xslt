<xsl:template match="/">
    <html>
        <head>
            <title>Rectangle</title>
            <link rel="stylesheet" href="style.css"/>
        </head>
        <body>
            <h1>Rectangle</h1>
            <p>Position: (<xsl:value-of select="rectangleData/x"/>, <xsl:value-of select="rectangleData/y"/>)</p>
            <p>Largeur: <xsl:value-of select="rectangleData/width"/></p>
            <p>Hauteur: <xsl:value-of select="rectangleData/height"/></p>
            <p>Aire: <xsl:value-of select="rectangleData/width * rectangleData/height"/></p>
        </body>
    </html>
</xsl:template>

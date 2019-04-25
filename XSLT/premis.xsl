<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:premis="http://www.loc.gov/premis/v3" xmlns:xlink="http://www.w3.org/1999/xlink" >
    <xsl:template match="/">
        <h2>Eventlog: <xsl:value-of select="premis:premis/premis:object/premis:objectIdentifier/premis:objectIdentifierType" />:<xsl:value-of select="premis:premis/premis:object/premis:objectIdentifier/premis:objectIdentifierValue" /></h2>
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Type</th>
                <th style="text-align:left">Date</th>
                <th style="text-align:left">ID</th>
                <th style="text-align:left">Event description</th>
            </tr>
        <xsl:for-each select="premis:premis/premis:event">
            <tr>
                <td><xsl:value-of select="premis:eventType"/></td>
                <td><xsl:value-of select="premis:eventDateTime"/></td>
                <td><xsl:value-of select="premis:eventIdentifier/premis:eventIdentifierValue"/></td>
                <td><xsl:value-of select="premis:eventOutcomeInformation/premis:eventOutcomeDetail/premis:eventOutcomeDetailNote"/></td>
            </tr>
        </xsl:for-each>
        </table>
        
    </xsl:template>
</xsl:stylesheet>

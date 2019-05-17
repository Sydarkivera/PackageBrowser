<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:ext="ExtensionMETS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink">

  <xsl:template name="formatdate">

    <xsl:param name="DateTimeStr"/>

    <xsl:variable name="datestr">
      <xsl:value-of select="substring-before($DateTimeStr,'T')"/>
    </xsl:variable>

    <xsl:variable name="mm">
      <xsl:value-of select="substring($datestr,6,2)"/>
    </xsl:variable>

    <xsl:variable name="dd">
      <xsl:value-of select="substring($datestr,9,2)"/>
    </xsl:variable>

    <xsl:variable name="yyyy">
      <xsl:value-of select="substring($datestr,1,4)"/>
    </xsl:variable>

    <xsl:value-of select="concat($yyyy, '-', $mm, '-', $dd)"/>
  </xsl:template>

  <xsl:template match="/">
    <!-- Values taken from the mets.xml field to match all the input fields in ETP -->
    <h1><xsl:value-of select="mets:mets/@LABEL"/>(<xsl:value-of select="mets:mets/mets:metsHdr/@ext:OAISSTATUS"/>),

      <xsl:call-template name="formatdate">
        <xsl:with-param name="DateTimeStr" select="mets:mets/mets:metsHdr/@CREATEDATE"/>
      </xsl:call-template>
    </h1>
    <h3 style="margin: 30px 10px; font-size:1.5em;">
      <b><xsl:value-of select="mets:mets/@OBJID"/></b>
    </h3>

    <table border="1">
      <tr bgcolor="#9acd32">
        <th style="text-align:left">ESSArch namn</th>
        <th style="text-align:left">FGS Paket elementnamn</th>
        <th style="text-align:left">Värde</th>
        <th style="text-align:left">XSLT sökväg till elementet</th>
      </tr>
      <!-- <tr> <td>UUID</td> <td>Identitet</td> <td><xsl:value-of select="mets:mets/@OBJID"/></td> <td>mets:mets/@OBJID</td> </tr> -->
      <tr>
        <td>Content Type</td>
        <td>Informationstyp</td>
        <td><xsl:value-of select="mets:mets/@TYPE"/></td>
        <td>mets:mets/@TYPE</td>
      </tr>
      <tr>
        <td>Access Restrict</td>
        <td>Sekretess</td>
        <td><xsl:value-of select="mets:mets/@ext:ACCESSRESTRICT"/></td>
        <td>mets:mets/@ext:ACCESSRESTRICT</td>
      </tr>
      <tr>
        <td>Archivist Organization
        </td>
        <td>Arkivbildare Namn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @TYPE='ORGANIZATION']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @TYPE='ORGANIZATION']/mets:name</td>
      </tr>
      <tr>
        <td>Archivist Organization Identity
        </td>
        <td>Arkivbildare Identitetskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @TYPE='ORGANIZATION']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @TYPE='ORGANIZATION']/mets:note</td>
      </tr>
      <tr>
        <td>Archivist Software
        </td>
        <td>System Namn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @OTHERTYPE='SOFTWARE']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @OTHERTYPE='SOFTWARE']/mets:name</td>
      </tr>
      <tr>
        <td>Archivist Software Notes
        </td>
        <td>System Version</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @OTHERTYPE='SOFTWARE']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='ARCHIVIST' and @OTHERTYPE='SOFTWARE']/mets:note</td>
      </tr>
      <tr>
        <td>Creator Organization
        </td>
        <td>Levererande organisation namn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='ORGANIZATION']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='ORGANIZATION']/mets:name</td>
      </tr>
      <tr>
        <td>Creator Organization Notes
        </td>
        <td>Levererande organisation Identitetskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='ORGANIZATION']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='ORGANIZATION']/mets:note</td>
      </tr>
      <tr>
        <td>Creator Software
        </td>
        <td>Levererande system namn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @OTHERTYPE='SOFTWARE']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @OTHERTYPE='SOFTWARE']/mets:name</td>
      </tr>
      <tr>
        <td>Creator Software Note
        </td>
        <td>Levererande system version</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @OTHERTYPE='SOFTWARE']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @OTHERTYPE='SOFTWARE']/mets:note</td>
      </tr>
      <tr>
        <td>Data Submission Session</td>
        <td>Överföring</td>
        <td><xsl:value-of select="mets:mets/@ext:DATASUBMISSIONSESSION"/></td>
        <td>mets:mets/@ext:DATASUBMISSIONSESSION</td>
      </tr>
      <tr>
        <td>Package Number</td>
        <td>Ordningsnummer inom överföring</td>
        <td><xsl:value-of select="mets:mets/@ext:PACKAGENUMBER"/></td>
        <td>mets:mets/@ext:PACKAGENUMBER</td>
      </tr>
      <tr>
        <td>Record Status</td>
        <td>Status</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/@RECORDSTATUS"/></td>
        <td>mets:mets/mets:metsHdr/@RECORDSTATUS</td>
      </tr>
      <tr>
        <td>Reference code</td>
        <td>Arkivets referenskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='REFERENCECODE']"/></td>
        <td>mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='REFERENCECODE']</td>
      </tr>
      <tr>
        <td>Producer Organization
        </td>
        <td>Producerande Organisationsnamn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@OTHERROLE='PRODUCER' and @TYPE='ORGANIZATION']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@OTHERROLE='PRODUCER' and @TYPE='ORGANIZATION']/mets:name</td>
      </tr>
      <tr>
        <td>Producer Organization Note
        </td>
        <td>Producerande Organisation Identitetskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@OTHERROLE='PRODUCER' and @TYPE='ORGANIZATION']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@OTHERROLE='PRODUCER' and @TYPE='ORGANIZATION']/mets:note</td>
      </tr>
      <tr>
        <td>System Type</td>
        <td>Systemtyp</td>
        <td><xsl:value-of select="mets:mets/@ext:SYSTEMTYPE"/></td>
        <td>mets:mets/@ext:SYSTEMTYPE</td>
      </tr>
      <tr>
        <td>Appraisal</td>
        <td>Gallring</td>
        <td><xsl:value-of select="mets:mets/@ext:APPRAISAL"/></td>
        <td>mets:mets/@ext:APPRAISAL</td>
      </tr>
      <tr>
        <td>Content Type Specification</td>
        <td>Informationstypsspecifikation</td>
        <td><xsl:value-of select="mets:mets/@ext:CONTENTTYPESPECIFICATION"/></td>
        <td>mets:mets/@ext:CONTENTTYPESPECIFICATION</td>
      </tr>
      <tr>
        <td>Agreement Form</td>
        <td>Avtalsform</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/@ext:AGREEMENTFORM"/></td>
        <td>mets:mets/mets:metsHdr/@ext:AGREEMENTFORM</td>
      </tr>
      <tr>
        <td>Previous Submission Agreement</td>
        <td>Tidigare Leveransöverenskommelse</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='PREVIOUSSUBMISSIONAGREEMENT']"/></td>
        <td>mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='PREVIOUSSUBMISSIONAGREEMENT']</td>
      </tr>
      <tr>
        <td>Previous Reference Code</td>
        <td>Tidigare referenskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='PREVIOUSREFERENCECODE']"/></td>
        <td>mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='PREVIOUSREFERENCECODE']</td>
      </tr>
      <tr>
        <td>Start Date</td>
        <td>Startdatum</td>
        <td>

          <xsl:call-template name="formatdate">
            <xsl:with-param name="DateTimeStr" select="mets:mets/@ext:STARTDATE"/>
          </xsl:call-template>
        </td>
        <td>mets:mets/@ext:STARTDATE</td>
      </tr>
      <tr>
        <td>End Date</td>
        <td>Slutdatum</td>
        <td>

          <xsl:call-template name="formatdate">
            <xsl:with-param name="DateTimeStr" select="mets:mets/@ext:ENDDATE"/>
          </xsl:call-template>
        </td>
        <td>mets:mets/@ext:ENDDATE</td>
      </tr>
      <tr>
        <td>Information Class</td>
        <td>Informationsklass</td>
        <td><xsl:value-of select="mets:mets/@ext:INFORMATIONCLASS"/></td>
        <td>mets:mets/@ext:INFORMATIONCLASS</td>
      </tr>
      <tr>
        <td>Editor Organization
        </td>
        <td>Konsultnamn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='EDITOR' and @TYPE='ORGANIZATION']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='EDITOR' and @TYPE='ORGANIZATION']/mets:name</td>
      </tr>
      <tr>
        <td>Editor Organization Note
        </td>
        <td>Konsult Identitetskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='EDITOR' and @TYPE='ORGANIZATION']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='EDITOR' and @TYPE='ORGANIZATION']/mets:note</td>
      </tr>
      <tr>
        <td>Preservation Organization
        </td>
        <td>Mottagare namn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='PRESERVATION' and @TYPE='ORGANIZATION']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='PRESERVATION' and @TYPE='ORGANIZATION']/mets:name</td>
      </tr>
      <tr>
        <td>Preservation Organization Note
        </td>
        <td>Mottagare Identitetskod</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='PRESERVATION' and @TYPE='ORGANIZATION']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='PRESERVATION' and @TYPE='ORGANIZATION']/mets:note</td>
      </tr>
      <tr>
        <td>Creator Individual
        </td>
        <td>Kontaktperson namn</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='INDIVIDUAL']/mets:name"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='INDIVIDUAL']/mets:name</td>
      </tr>
      <tr>
        <td>Creator Individual Note
        </td>
        <td>Kontaktperson Kontaktuppgifter</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='INDIVIDUAL']/mets:note"/></td>
        <td>mets:mets/mets:metsHdr/mets:agent[@ROLE='CREATOR' and @TYPE='INDIVIDUAL']/mets:note</td>
      </tr>
      <tr>
        <td>Submission Agreement</td>
        <td>-</td>
        <td><xsl:value-of select="mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='SUBMISSIONAGREEMENT']"/></td>
        <td>mets:mets/mets:metsHdr/mets:altRecordID[@TYPE='SUBMISSIONAGREEMENT']</td>
      </tr>

    </table>

    <!-- A list of all agents present in the mets.xml file-->
    <!-- <table border="1"> <tr bgcolor="#9acd32"> <th style="text-align:left">Name</th> <th style="text-align:left">Note</th> <th style="text-align:left">Role</th> <th style="text-align:left">Type</th> </tr> <xsl:for-each
    select="mets:mets/mets:metsHdr/mets:agent"> <tr> <td><xsl:value-of select="mets:name"/></td> <td><xsl:value-of select="mets:note"/></td> <xsl:choose> <xsl:when test="@ROLE = 'OTHER'"> <td><xsl:value-of select="@OTHERROLE"/></td> </xsl:when>
    <xsl:otherwise> <td><xsl:value-of select="@ROLE"/></td> </xsl:otherwise> </xsl:choose> <xsl:choose> <xsl:when test="@TYPE = 'OTHER'"> <td><xsl:value-of select="@OTHERTYPE"/></td> </xsl:when> <xsl:otherwise> <td><xsl:value-of select="@TYPE"/></td>
    </xsl:otherwise> </xsl:choose> </tr> </xsl:for-each> </table> -->
    <!-- <div class="divider"><br/></div> -->

    <!-- A list of all files present in the xml file -->
    <h2>Innehåll:</h2>
    <div class="Search">
      <input type="text" placeholder="Filnamn" name="FileName" id="FileName" value="{$fileSearch}"/>
      <input type="text" placeholder="MIME type" name="mimeType" id="mimeType" value="{$mimeSearch}"/>
      <input type="button" value="Sök" onclick="search()"/>
    </div>

    <xsl:if test="$min &gt;= 0">
      <a>

        <xsl:attribute name='href'>

          <xsl:value-of select="$url"/>&amp;disp=<xsl:value-of select="$min"/>
        </xsl:attribute>
        Prev
      </a>
    </xsl:if>

    <xsl:if test="$max &lt; count(mets:mets/mets:fileSec/mets:fileGrp/mets:file)">
      <a>

        <xsl:attribute name='href'>

          <xsl:value-of select="$url"/>&amp;disp=<xsl:value-of select="$max"/>
        </xsl:attribute>
        Next
      </a>
    </xsl:if>
    <select onChange="displayElementsChanged(this)">
      <option value="10">

        <xsl:if test="$limit = 10">
          <xsl:attribute name="selected"/>
        </xsl:if>
        10
      </option>
      <option value="50">

        <xsl:if test="$limit = 50">
          <xsl:attribute name="selected"/>
        </xsl:if>
        50
      </option>
      <option value="100">

        <xsl:if test="$limit = 100">
          <xsl:attribute name="selected"/>
        </xsl:if>
        100
      </option>
      <!-- <option value="audi">Audi</option> -->
    </select>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th style="text-align:left">File reference</th>
        <th style="text-align:left">MIME type</th>
        <th style="text-align:left">Created date</th>
        <th style="text-align:left">Size</th>
        <th style="text-align:left">UUID</th>
      </tr>

      <xsl:for-each select="mets:mets/mets:fileSec/mets:fileGrp/mets:file[position() &gt;= $disp+1 and position() &lt; $max+1]">

        <xsl:sort select="mets:FLocat/@xlink:href"/>

        <xsl:if test="contains(mets:FLocat/@xlink:href, $fileSearch)">

          <xsl:if test="contains(@MIMETYPE, $mimeSearch)">
            <tr>
              <td>
                <a>

                  <xsl:if test="mets:FLocat/@LOCTYPE = 'URL'">

                    <xsl:attribute name="id">
                      <xsl:value-of select="substring-after(mets:FLocat/@xlink:href, 'file:///')"/>
                    </xsl:attribute>

                    <xsl:attribute name="onclick">openFile(this)</xsl:attribute>
                  </xsl:if>

                  <xsl:value-of select="substring-after(mets:FLocat/@xlink:href, 'file:///')"/>
                </a>
              </td>
              <td><xsl:value-of select="@MIMETYPE"/></td>
              <td>

                <xsl:call-template name="formatdate">
                  <xsl:with-param name="DateTimeStr" select="@CREATED"/>
                </xsl:call-template>
              </td>
              <td><xsl:value-of select="@SIZE"/></td>
              <td><xsl:value-of select="substring-after(@ID, 'ID')"/></td>
            </tr>
          </xsl:if>
        </xsl:if>
      </xsl:for-each>
    </table>

    <xsl:if test="$min &gt;= 0">
      <a>

        <xsl:attribute name='href'>

          <xsl:value-of select="$url"/>&amp;disp=<xsl:value-of select="$min"/>
        </xsl:attribute>
        Prev
      </a>
    </xsl:if>

    <xsl:if test="$max &lt; count(mets:mets/mets:fileSec/mets:fileGrp/mets:file)">
      <a>

        <xsl:attribute name='href'>

          <xsl:value-of select="$url"/>&amp;disp=<xsl:value-of select="$max"/>
        </xsl:attribute>
        Next
      </a>
    </xsl:if>
    <select onChange="displayElementsChanged(this)">
      <option value="10">

        <xsl:if test="$limit = 10">
          <xsl:attribute name="selected"/>
        </xsl:if>
        10
      </option>
      <option value="50">

        <xsl:if test="$limit = 50">
          <xsl:attribute name="selected"/>
        </xsl:if>
        50
      </option>
      <option value="100">

        <xsl:if test="$limit = 100">
          <xsl:attribute name="selected"/>
        </xsl:if>
        100
      </option>
    </select>

  </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="ISO-8859-1"?>

<!--   ***********************************************************************************************************
	Edited by Tyler Thorsted thorsted@byu.edu
	Added "[string-length() != 0]" to transform to avoid empty properties. Rosetta wil error is value of proerty is null.	
		********************************************************************************************************** -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'   xmlns:et='http://ns.exiftool.org/1.0/' et:toolkit='Image::ExifTool 12.60'
  xmlns:ExifTool='http://ns.exiftool.org/ExifTool/1.0/' xmlns:System='http://ns.exiftool.org/File/System/1.0/' xmlns:File='http://ns.exiftool.org/File/1.0/'
  xmlns:PDF='http://ns.exiftool.org/PDF/PDF/1.0/' xmlns:XMP-x='http://ns.exiftool.org/XMP/XMP-x/1.0/' xmlns:XMP-pdf='http://ns.exiftool.org/XMP/XMP-pdf/1.0/' xmlns:XMP-xmp='http://ns.exiftool.org/XMP/XMP-xmp/1.0/'
  xmlns:XMP-dc='http://ns.exiftool.org/XMP/XMP-dc/1.0/' xmlns:XMP-xmpRights='http://ns.exiftool.org/XMP/XMP-xmpRights/1.0/' xmlns:XMP-cc='http://ns.exiftool.org/XMP/XMP-cc/1.0/'
  xmlns:XMP-xmpMM='http://ns.exiftool.org/XMP/XMP-xmpMM/1.0/'>
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="/rdf:RDF/rdf:Description"/>
		
	</xsl:template>
	<xsl:template match="rdf:Description">
		<xsl:element name="mdExtractor" xmlns="http://com/exlibris/digitool/repository/api/xmlbeans">
			<xsl:element name="profile" />
			<xsl:element name="format_name">
				<xsl:value-of select="/rdf:RDF/rdf:Description/File:FileType[string-length() != 0]" />
			</xsl:element>
			<xsl:element name="formatVersion" />
			<xsl:element name="mimeType">
				<xsl:value-of select="/rdf:RDF/rdf:Description/File:MIMEType[string-length() != 0]" />
			</xsl:element>
			<xsl:element name="imageCount" />
			<xsl:element name="isValid">
				true
			</xsl:element>
			<xsl:element name="isWellFormed">
				true
			</xsl:element>
			<xsl:element name="agent">
				<xsl:text>ExifTool </xsl:text>
				<xsl:value-of select="/rdf:RDF/rdf:Description/ExifTool:ExifToolVersion" />
			</xsl:element>
			<xsl:element name="attributes">
				<xsl:variable name="myList">
					<xsl:value-of select="document('properties.xml')" />
				</xsl:variable>
				
				<!--				<xsl:for-each select="/rdf:RDF/rdf:Description/*[not(*)][string-length() != 0]"> -->
				<xsl:for-each select="/rdf:RDF/rdf:Description/*[string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:value-of select="name(.)" />
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:element name="key">
							<xsl:attribute name="id">
								<xsl:value-of select="name(.)" />
							</xsl:attribute>
							<xsl:value-of select="." />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
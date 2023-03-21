<?xml version="1.0" encoding="ISO-8859-1"?>

<!--   ***********************************************************************************************************
	Edited by Tyler Thorsted thorsted@ChurchofJesusChrist.org
	Added "[string-length() != 0]" to transform to avoid empty properties. Rosetta wil error is value of proerty is null.
	
	Included is a commented out section for taking the first "HeadingPair value and mapping the value to the property. Needs to be expanded to be recursive.
	
		********************************************************************************************************** -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#' rdf:about='C:/Users/Public/Pictures/Sample Pictures/Tulips.jpg'
	xmlns:et='http://ns.exiftool.ca/1.0/' et:toolkit='Image::ExifTool 9.93' xmlns:ExifTool='http://ns.exiftool.ca/ExifTool/1.0/'
	xmlns:System='http://ns.exiftool.ca/File/System/1.0/' xmlns:File='http://ns.exiftool.ca/File/1.0/' xmlns:JFIF='http://ns.exiftool.ca/JFIF/JFIF/1.0/'
	xmlns:IFD0='http://ns.exiftool.ca/EXIF/IFD0/1.0/' xmlns:ExifIFD='http://ns.exiftool.ca/EXIF/ExifIFD/1.0/' xmlns:IFD1='http://ns.exiftool.ca/EXIF/IFD1/1.0/'
	xmlns:Ducky='http://ns.exiftool.ca/Ducky/Ducky/1.0/' xmlns:Adobe='http://ns.exiftool.ca/APP14/Adobe/1.0/' xmlns:XMP-x='http://ns.exiftool.ca/XMP/XMP-x/1.0/'
	xmlns:XMP-tiff='http://ns.exiftool.ca/XMP/XMP-tiff/1.0/' xmlns:XMP-xmp='http://ns.exiftool.ca/XMP/XMP-xmp/1.0/'
	xmlns:XMP-microsoft='http://ns.exiftool.ca/XMP/XMP-microsoft/1.0/' xmlns:XMP-xmpMM='http://ns.exiftool.ca/XMP/XMP-xmpMM/1.0/'
	xmlns:XMP-exif='http://ns.exiftool.ca/XMP/XMP-exif/1.0/' xmlns:XMP-crs='http://ns.exiftool.ca/XMP/XMP-crs/1.0/'
	xmlns:XMP-photoshop='http://ns.exiftool.ca/XMP/XMP-photoshop/1.0/' xmlns:XMP-xmpRights='http://ns.exiftool.ca/XMP/XMP-xmpRights/1.0/'
	xmlns:XMP-dc='http://ns.exiftool.ca/XMP/XMP-dc/1.0/' xmlns:IPTC='http://ns.exiftool.ca/IPTC/IPTC/1.0/' xmlns:Photoshop='http://ns.exiftool.ca/Photoshop/Photoshop/1.0/'
	xmlns:Composite='http://ns.exiftool.ca/Composite/1.0/' xmlns:XML='http://ns.exiftool.ca/XML/XML/1.0/'>
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
				<!--				<xsl:for-each select="/rdf:RDF/rdf:Description/XML:HeadingPairs/rdf:Bag/*[2][string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:value-of select="name(../..)" />
					</xsl:variable>
					<xsl:variable name="hp1"><xsl:value-of select="/rdf:RDF/rdf:Description/XML:HeadingPairs/rdf:Bag/rdf:li"/></xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:element name="key">
							<xsl:attribute name="id">
								<xsl:value-of select="name(../..)" />.<xsl:value-of select="$hp1"/>
							</xsl:attribute>
							<xsl:value-of select="." />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
			-->
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
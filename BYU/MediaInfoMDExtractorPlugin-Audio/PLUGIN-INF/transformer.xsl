<?xml version="1.0" encoding="ISO-8859-1"?>

<!--   ***********************************************************************************************************
	Edited by Kimberly A. Tryka - National Geographic Society - 7 October 2019
	Edits made to work with xml output from MediaInfo version 19.09
	Changes made:
		- bound namespace prefix (mi) to namespace in <xsl:stylesheet>
		- added exclude-result-prefixes to <xsl:stylesheet>
		- all references to <Mediainfo> were changed to <MediaInfo>
		- all references to <File> were changed to <media>
		- used namespace prefix when referencing elements from the MediaInfo output file
		
	Tested using xsltproc (via command line) on linux
	Currently running properly in our Rosetta 6.1 implementation
	Developed and tested (Saxon PE) in Oxygen
	
	Note - changes also need to be made to properties.xml file to account for changes in 
	element names in MediaInfo.  For example <File_properties> has become <File_Properties>
	and <codec_ID> has become <codecID> - this is not an exhaustive list of these changes
	
	Note - after changes have been made to the properties.xml file - you will need to re-map
	the fields for the extractor
	********************************************************************************************************** -->
<!--   ***********************************************************************************************************
	Updated by Tyler Thorsted - Chrch of Jesus Christ of Latter-dayt Saints - April 2020
	Added the "Extra" tags for General & Video
		********************************************************************************************************** -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:mi="https://mediaarea.net/mediainfo"
	exclude-result-prefixes="xs mi"
	version="1.0">
	
	<xsl:output encoding="UTF-8" method="xml" indent="yes"/>
	
	<xsl:variable name="genPath">mediainfo.track.General.</xsl:variable>
	<xsl:variable name="genxPath">mediainfo.track.General.extra.</xsl:variable>
	<xsl:variable name="vidPath">mediainfo.track.Video.</xsl:variable>
	<xsl:variable name="vidxPath">mediainfo.track.Video.extra.</xsl:variable>
	<xsl:variable name="audPath">mediainfo.track.Audio.</xsl:variable>
	<xsl:variable name="imgPath">mediainfo.track.Image.</xsl:variable>
	<xsl:variable name="txtPath">mediainfo.track.Text.</xsl:variable>
	<xsl:variable name="otrPath">mediainfo.track.Other.</xsl:variable>
	
	<xsl:template match="/">
		<xsl:element name="mdExtractor" xmlns="http://com/exlibris/digitool/repository/api/xmlbeans">
			<xsl:element name="profile"/>
			<xsl:element name="format_name"><xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='General']/mi:Format[1]" /></xsl:element>
			<xsl:element name="formatVersion"><xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='General']/mi:Format_Version" /></xsl:element>
			<xsl:element name="imageCount"/>
			<xsl:element name="isValid">true</xsl:element>
			<xsl:element name="isWellFormed">true</xsl:element>
			<xsl:element name="attributes">
				<xsl:variable name="myList">
					<xsl:value-of select="document('properties.xml')"/>
				</xsl:variable>
				
				<!-- General -->
				<xsl:for-each select="/mi:MediaInfo/mi:media/mi:track[@type='General']/*[not(descendant::mi:extra) and not(ancestor-or-self::mi:extra)]">
					<xsl:variable name="prop">
						<xsl:text>General.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'General.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($genPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='General']/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
				
				<!-- General Extra-->
				<xsl:for-each select="/mi:MediaInfo/mi:media/mi:track[@type='General']/mi:extra/*">
					<xsl:variable name="prop">
						<xsl:text>General.extra.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'General.extra.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($genxPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='General']/mi:extra/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
				<!-- Video -->
				<xsl:for-each select="/mi:MediaInfo/mi:media/mi:track[@type='Video']/*[not(descendant::mi:extra) and not(ancestor-or-self::mi:extra)]">
					<xsl:variable name="prop">
						<xsl:text>Video.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'Video.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($vidPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='Video']/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
				<!-- Video Extra -->
				<xsl:for-each select="/mi:MediaInfo/mi:media/mi:track[@type='Video']/mi:extra/*">
					<xsl:variable name="prop">
						<xsl:text>Video.extra.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'Video.extra.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($vidxPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='Video']/mi:extra/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
				<!-- Audio -->
				<xsl:for-each select="/mi:MediaInfo/mi:media/mi:track[@type='Audio']/*">
					<xsl:variable name="prop">
						<xsl:text>Audio.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'Audio.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($audPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='Audio']/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
				<!-- Image -->
				<xsl:for-each select="/mi:MediaInfo/mi:media/mi:track[@type='Image']/*">
					<xsl:variable name="prop">
						<xsl:text>Image.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'Image.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($imgPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/mi:MediaInfo/mi:media/mi:track[@type='Image']/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>
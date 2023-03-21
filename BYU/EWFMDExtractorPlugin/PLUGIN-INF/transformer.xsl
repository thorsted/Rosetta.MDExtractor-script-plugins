<?xml version="1.0" encoding="ISO-8859-1"?>

<!--   ***********************************************************************************************************
	Created by Tyler Thorsted - BYU - March 2023
		********************************************************************************************************** -->
		
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://libewf.sourceforge.net/"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/">
	<xsl:output method="xml" indent="yes" />
	<xsl:strip-space elements="*"/>
	
		<xsl:variable name="mdPath">ewfobjects.metadata.</xsl:variable>
		<xsl:variable name="crPath">ewfobjects.creator.</xsl:variable>
		<xsl:variable name="crbPath">ewfobjects.creator.build_environment.</xsl:variable>
		<xsl:variable name="ifPath">ewfobjects.ewfinfo.image_filenames.</xsl:variable>
		<xsl:variable name="aiPath">ewfobjects.ewfinfo.acquiry_information.</xsl:variable>
		<xsl:variable name="eiPath">ewfobjects.ewfinfo.ewf_information.</xsl:variable>
		<xsl:variable name="miPath">ewfobjects.ewfinfo.media_information.</xsl:variable>
		<xsl:variable name="iPath">ewfobjects.ewfinfo.</xsl:variable>
		<xsl:variable name="isPath">ewfobjects.ewfinfo.sessions.</xsl:variable>
		<xsl:variable name="iaPath">ewfobjects.ewfinfo.acquisition_read_errors.</xsl:variable>
			
	<xsl:template match="/">

		<xsl:element name="mdExtractor" xmlns="http://com/exlibris/digitool/repository/api/xmlbeans">
			<xsl:element name="profile" />
			<xsl:element name="format_name">
				<xsl:value-of select="/ewfobjects/ewfinfo/ewf_information/file_format[string-length() != 0]" />
			</xsl:element>
			<xsl:element name="formatVersion" />
			<xsl:element name="mimeType">application/encase</xsl:element>
			<xsl:element name="isValid">true</xsl:element>
			<xsl:element name="isWellFormed">true</xsl:element>
			<xsl:element name="agent">
				<xsl:text>ewfinfo </xsl:text>
				<xsl:value-of select="/ewfobjects/creator/version" />
			</xsl:element>
			<xsl:element name="attributes">
				<xsl:variable name="myList">
					<xsl:value-of select="document('properties.xml')" />
				</xsl:variable>
				
				<!-- Creator -->
				<xsl:for-each select="/ewfobjects/creator/*[not(descendant::build_environment) and not(ancestor or self::build_environment)][string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:text>creator.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'creator.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($crPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/creator/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>

				<!-- Creator Build -->
				<xsl:for-each select="/ewfobjects/creator/build_environment/*[string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:text>creator.build_environment.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'creator.build_environment.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($crbPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/creator/build_environment/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
				<!-- EWFInfo filenames -->
				<xsl:for-each select="/ewfobjects/ewfinfo/image_filenames/*[string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.image_filenames.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'ewfinfo.image_filenames.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($ifPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/ewfinfo/image_filenames/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
								<!-- acquiry information -->
				<xsl:for-each select="/ewfobjects/ewfinfo/acquiry_information/*[string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.acquiry_information.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'ewfinfo.acquiry_information.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($aiPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/ewfinfo/acquiry_information/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
								<!-- ewf information -->
				<xsl:for-each select="/ewfobjects/ewfinfo/ewf_information/*[string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.ewf_information.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'ewfinfo.ewf_information.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($eiPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/ewfinfo/ewf_information/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
								<!-- media information -->
				<xsl:for-each select="/ewfobjects/ewfinfo/media_information/*[string-length() != 0]">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.media_information.</xsl:text><xsl:value-of select="name(.)"/>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:variable name="attName">
							<xsl:value-of select="substring-after($prop,'ewfinfo.media_information.')"/>
						</xsl:variable>
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($miPath,$attName)"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/ewfinfo/media_information/*[name()=$attName][1]" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
								<!-- hashdigest md5-->
				<xsl:for-each select="/ewfobjects/ewfinfo/hashdigest[@type='md5']">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.hashdigest.md5</xsl:text>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($iPath,'hashdigest.md5')"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/ewfinfo/hashdigest[@type='md5']" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
												<!-- hashdigest sha1-->
				<xsl:for-each select="/ewfobjects/ewfinfo/hashdigest[@type='sha1']">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.hashdigest.sha1</xsl:text>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($iPath,'hashdigest.sha1')"/></xsl:attribute>
							<xsl:value-of select="/ewfobjects/ewfinfo/hashdigest[@type='sha1']" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
												<!-- sessions -->
				<xsl:for-each select="/ewfobjects/ewfinfo/sessions/*">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.sessions.count</xsl:text>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($isPath,'count')"/></xsl:attribute>
							<xsl:value-of select="count(/ewfobjects/ewfinfo/sessions/run)" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
																<!-- sessions -->
				<xsl:for-each select="/ewfobjects/ewfinfo/acquisition_read_errors/*">
					<xsl:variable name="prop">
						<xsl:text>ewfinfo.acquisition_read_errors.count</xsl:text>
					</xsl:variable>
					<xsl:if test="contains($myList,$prop)">
						<xsl:element name="key">
							<xsl:attribute name="id"><xsl:value-of select="concat($iaPath,'count')"/></xsl:attribute>
							<xsl:value-of select="count(/ewfobjects/ewfinfo/acquisition_read_errors/run)" />
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
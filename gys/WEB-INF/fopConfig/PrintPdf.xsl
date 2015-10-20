<?xml version="1.0" encoding="GBK"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="simple"
					page-height="21cm" page-width="29.7cm" margin-top="0cm"
					margin-bottom="0cm" margin-left="2cm" margin-right="2cm">
					<fo:region-body margin-top="1cm"
						margin-bottom="1cm" />
					<fo:region-before extent="1.5cm" />
					<fo:region-after extent="1cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<xsl:for-each select="/page/cover">
				<xsl:if test="@show">
					<xsl:choose>
						<xsl:when test="@show='true'">
							<xsl:for-each select="/page/cover/pages">
								<fo:page-sequence
									master-reference="simple">
									<fo:static-content
										flow-name="xsl-region-before">
										<xsl:for-each
											select="/page/page-header">
											<fo:table>
												<fo:table-body>
													<fo:table-row
														height="0.5cm">
														<fo:table-cell
															border-bottom="0.5px solid gray" display-align="after"
															width="13cm">
															<fo:block
																font="Simsun" font-size="10pt" color="black">
																<xsl:if
																	test="@font">
																	<xsl:attribute
																		name="font-family">
																		<xsl:value-of
																			select="@font" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@font-size">
																	<xsl:attribute
																		name="font-size">
																		<xsl:value-of
																			select="@font-size" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@color">
																	<xsl:attribute
																		name="color">
																		<xsl:value-of
																			select="@color" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@align">
																	<xsl:attribute
																		name="text-align">
																		<xsl:value-of
																			select="@align" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@text-decoration">
																	<xsl:attribute
																		name="text-decoration">
																		<xsl:value-of
																			select="@text-decoration" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:value-of
																	select="." />
															</fo:block>
														</fo:table-cell>
														<fo:table-cell
															border-bottom="0.5px solid gray" display-align="after"
															width="6cm">
															<xsl:if
																test="@font">
																<xsl:attribute
																	name="font-family">
																	<xsl:value-of
																		select="@font" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@font-size">
																<xsl:attribute
																	name="font-size">
																	<xsl:value-of
																		select="@font-size" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@color">
																<xsl:attribute
																	name="color">
																	<xsl:value-of
																		select="@color" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@align">
																<xsl:attribute
																	name="text-align">
																	<xsl:value-of
																		select="@align" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@text-decoration">
																<xsl:attribute
																	name="text-decoration">
																	<xsl:value-of
																		select="@text-decoration" />
																</xsl:attribute>
															</xsl:if>
															<fo:block
																text-align="right">
																第
																<fo:page-number />
																页 共
																<xsl:value-of
																	select="/page/total-pages" />
																页
															</fo:block>
														</fo:table-cell>
													</fo:table-row>
												</fo:table-body>
											</fo:table>
										</xsl:for-each>
									</fo:static-content>
									<fo:static-content
										flow-name="xsl-region-after">
										<xsl:for-each
											select="/page/page-footer">
											<fo:table>
												<fo:table-body>
													<fo:table-row
														height="0.5cm">
														<fo:table-cell
															display-align="before" width="19cm">
															<fo:block
																font="Simsun" font-size="10pt" color="black">
																<xsl:if
																	test="@font">
																	<xsl:attribute
																		name="font-family">
																		<xsl:value-of
																			select="@font" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@font-size">
																	<xsl:attribute
																		name="font-size">
																		<xsl:value-of
																			select="@font-size" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@color">
																	<xsl:attribute
																		name="color">
																		<xsl:value-of
																			select="@color" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@align">
																	<xsl:attribute
																		name="text-align">
																		<xsl:value-of
																			select="@align" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:if
																	test="@text-decoration">
																	<xsl:attribute
																		name="text-decoration">
																		<xsl:value-of
																			select="@text-decoration" />
																	</xsl:attribute>
																</xsl:if>
																<xsl:value-of
																	select="." />
															</fo:block>
														</fo:table-cell>
													</fo:table-row>
												</fo:table-body>
											</fo:table>
										</xsl:for-each>
									</fo:static-content>
									<fo:flow
										flow-name="xsl-region-body">
										<xsl:for-each select="table">
											<fo:table>
												<fo:table-body>
													<xsl:for-each
														select="tr">
														<fo:table-row>
															<xsl:if
																test="@height">
																<xsl:attribute
																	name="height">
																	<xsl:value-of
																		select="@height" />
																</xsl:attribute>
															</xsl:if>
															<xsl:for-each
																select="td">
																<fo:table-cell
																	display-align="center">
																	<xsl:if
																		test="@width">
																		<xsl:attribute
																			name="width">
																			<xsl:value-of
																				select="@width" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@border">
																		<xsl:attribute
																			name="border">
																			<xsl:value-of
																				select="@border" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@border-bottom">
																		<xsl:attribute
																			name="border-bottom">
																			<xsl:value-of
																				select="@border-bottom" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@border-top">
																		<xsl:attribute
																			name="border-top">
																			<xsl:value-of
																				select="@border-top" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@border-left">
																		<xsl:attribute
																			name="border-left">
																			<xsl:value-of
																				select="@border-left" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@border-right">
																		<xsl:attribute
																			name="border-right">
																			<xsl:value-of
																				select="@border-right" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@colspan">
																		<xsl:attribute
																			name="number-columns-spanned">
																			<xsl:value-of
																				select="@colspan" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@rowspan">
																		<xsl:attribute
																			name="number-rows-spanned">
																			<xsl:value-of
																				select="@rowspan" />
																		</xsl:attribute>
																	</xsl:if>
																	<xsl:if
																		test="@valign">
																		<xsl:choose>
																			<xsl:when
																				test="@valign='middle'">
																				<xsl:attribute
																					name="display-align">
																					center
																				</xsl:attribute>
																			</xsl:when>
																			<xsl:when
																				test="@valign='top'">
																				<xsl:attribute
																					name="display-align">
																					before
																				</xsl:attribute>
																			</xsl:when>
																			<xsl:when
																				test="@valign='bottom'">
																				<xsl:attribute
																					name="display-align">
																					after
																				</xsl:attribute>
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:attribute
																					name="display-align">
																					center
																				</xsl:attribute>
																			</xsl:otherwise>
																		</xsl:choose>
																	</xsl:if>
																	<xsl:for-each
																		select="p">
																		<fo:block
																			start-indent="2pt" end-indent="2pt">
																			<xsl:if
																				test="@font">
																				<xsl:attribute
																					name="font-family">
																					<xsl:value-of
																						select="@font" />
																				</xsl:attribute>
																			</xsl:if>
																			<xsl:if
																				test="@font-size">
																				<xsl:attribute
																					name="font-size">
																					<xsl:value-of
																						select="@font-size" />
																				</xsl:attribute>
																			</xsl:if>
																			<xsl:if
																				test="@color">
																				<xsl:attribute
																					name="color">
																					<xsl:value-of
																						select="@color" />
																				</xsl:attribute>
																			</xsl:if>
																			<xsl:if
																				test="@align">
																				<xsl:attribute
																					name="text-align">
																					<xsl:value-of
																						select="@align" />
																				</xsl:attribute>
																			</xsl:if>
																			<xsl:if
																				test="@text-decoration">
																				<xsl:attribute
																					name="text-decoration">
																					<xsl:value-of
																						select="@text-decoration" />
																				</xsl:attribute>
																			</xsl:if>
																			<xsl:value-of
																				select="." />
																		</fo:block>
																	</xsl:for-each>
																</fo:table-cell>
															</xsl:for-each>
														</fo:table-row>
													</xsl:for-each>
												</fo:table-body>
											</fo:table>
										</xsl:for-each>
									</fo:flow>
								</fo:page-sequence>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="/page/pages">
				<fo:page-sequence master-reference="simple">
					<fo:static-content flow-name="xsl-region-before">
						<xsl:for-each select="/page/page-header">
							<fo:table>
								<fo:table-body>
									<fo:table-row height="0.5cm">
										<fo:table-cell display-align="after">
											<fo:block font="Simsun"
												font-size="10pt" color="black">
												<xsl:if test="@font">
													<xsl:attribute
														name="font-family">
														<xsl:value-of
															select="@font" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if
													test="@font-size">
													<xsl:attribute
														name="font-size">
														<xsl:value-of
															select="@font-size" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if test="@color">
													<xsl:attribute
														name="color">
														<xsl:value-of
															select="@color" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if test="@align">
													<xsl:attribute
														name="text-align">
														<xsl:value-of
															select="@align" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if
													test="@text-decoration">
													<xsl:attribute
														name="text-decoration">
														<xsl:value-of
															select="@text-decoration" />
													</xsl:attribute>
												</xsl:if>
												<xsl:value-of
													select="." />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell display-align="after">
											<xsl:if test="@font">
												<xsl:attribute
													name="font-family">
													<xsl:value-of
														select="@font" />
												</xsl:attribute>
											</xsl:if>
											<xsl:if test="@font-size">
												<xsl:attribute
													name="font-size">
													<xsl:value-of
														select="@font-size" />
												</xsl:attribute>
											</xsl:if>
											<xsl:if test="@color">
												<xsl:attribute
													name="color">
													<xsl:value-of
														select="@color" />
												</xsl:attribute>
											</xsl:if>
											<xsl:if test="@align">
												<xsl:attribute
													name="text-align">
													<xsl:value-of
														select="@align" />
												</xsl:attribute>
											</xsl:if>
											<xsl:if
												test="@text-decoration">
												<xsl:attribute
													name="text-decoration">
													<xsl:value-of
														select="@text-decoration" />
												</xsl:attribute>
											</xsl:if>
											<fo:block
												text-align="right">
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</xsl:for-each>
					</fo:static-content>
					<fo:static-content flow-name="xsl-region-after">
						<xsl:for-each select="/page/page-footer">
							<fo:table>
								<fo:table-body>
									<fo:table-row height="0.5cm">
										<fo:table-cell
											display-align="before" width="19cm">
											<fo:block font="Simsun"
												font-size="10pt" color="black">
												<xsl:if test="@font">
													<xsl:attribute
														name="font-family">
														<xsl:value-of
															select="@font" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if
													test="@font-size">
													<xsl:attribute
														name="font-size">
														<xsl:value-of
															select="@font-size" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if test="@color">
													<xsl:attribute
														name="color">
														<xsl:value-of
															select="@color" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if test="@align">
													<xsl:attribute
														name="text-align">
														<xsl:value-of
															select="@align" />
													</xsl:attribute>
												</xsl:if>
												<xsl:if
													test="@text-decoration">
													<xsl:attribute
														name="text-decoration">
														<xsl:value-of
															select="@text-decoration" />
													</xsl:attribute>
												</xsl:if>
												<xsl:value-of
													select="." />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</xsl:for-each>
					</fo:static-content>
					<fo:flow flow-name="xsl-region-body">
						<xsl:for-each select="table">
							<fo:table>
								<fo:table-body>
									<xsl:for-each select="tr">
										<fo:table-row>
											<xsl:if test="@height">
												<xsl:attribute
													name="height">
													<xsl:value-of
														select="@height" />
												</xsl:attribute>
											</xsl:if>
											<xsl:for-each select="td">
												<fo:table-cell
													display-align="center">
													<xsl:if
														test="@width">
														<xsl:attribute
															name="width">
															<xsl:value-of
																select="@width" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@border">
														<xsl:attribute
															name="border">
															<xsl:value-of
																select="@border" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@border-bottom">
														<xsl:attribute
															name="border-bottom">
															<xsl:value-of
																select="@border-bottom" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@border-top">
														<xsl:attribute
															name="border-top">
															<xsl:value-of
																select="@border-top" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@border-left">
														<xsl:attribute
															name="border-left">
															<xsl:value-of
																select="@border-left" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@border-right">
														<xsl:attribute
															name="border-right">
															<xsl:value-of
																select="@border-right" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@colspan">
														<xsl:attribute
															name="number-columns-spanned">
															<xsl:value-of
																select="@colspan" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@rowspan">
														<xsl:attribute
															name="number-rows-spanned">
															<xsl:value-of
																select="@rowspan" />
														</xsl:attribute>
													</xsl:if>
													<xsl:if
														test="@valign">
														<xsl:choose>
															<xsl:when
																test="@valign='middle'">
																<xsl:attribute
																	name="display-align">
																	center
																</xsl:attribute>
															</xsl:when>
															<xsl:when
																test="@valign='top'">
																<xsl:attribute
																	name="display-align">
																	before
																</xsl:attribute>
															</xsl:when>
															<xsl:when
																test="@valign='bottom'">
																<xsl:attribute
																	name="display-align">
																	after
																</xsl:attribute>
															</xsl:when>
															<xsl:otherwise>
																<xsl:attribute
																	name="display-align">
																	center
																</xsl:attribute>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:if>
													<xsl:for-each
														select="p">
														<fo:block
															start-indent="2pt" end-indent="2pt">
															<xsl:if
																test="@font">
																<xsl:attribute
																	name="font-family">
																	<xsl:value-of select="@font" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@font-size">
																<xsl:attribute
																	name="font-size">
																	<xsl:value-of
																		select="@font-size" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@color">
																<xsl:attribute
																	name="color">
																	<xsl:value-of
																		select="@color" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@align">
																<xsl:attribute
																	name="text-align">
																	<xsl:value-of
																		select="@align" />
																</xsl:attribute>
															</xsl:if>
															<xsl:if
																test="@text-decoration">
																<xsl:attribute
																	name="text-decoration">
																	<xsl:value-of
																		select="@text-decoration" />
																</xsl:attribute>
															</xsl:if>
															<xsl:value-of
																select="." />
														</fo:block>
													</xsl:for-each>
												</fo:table-cell>
											</xsl:for-each>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</xsl:for-each>
					</fo:flow>
				</fo:page-sequence>
			</xsl:for-each>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>

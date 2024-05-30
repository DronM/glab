<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
 xmlns:html="http://www.w3.org/TR/REC-html40"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- 
<xsl:import href="ModelsToHTML.html.xsl"/>
-->
<xsl:import href="functions.xsl"/>


<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="not(document/model[@id='Response']/row[1]/result='0')">
		<xsl:apply-templates select="document/model[@id='Response']"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="document/model[@id='RepHead']"/>
			<xsl:apply-templates select="document/model[@id='RepBalanceList']"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<!-- Head -->
<xsl:template match="model[@id='RepHead']">
	<h3>Отчет движения по кассе за период <xsl:value-of select="row/period_descr"/></h3>	
</xsl:template>

<xsl:template match="model[@id='RepBalanceList']">
	<xsl:variable name="model_id" select="@id"/>
	
	<table id="{$model_id}" class="table table-bordered table-responsive table-striped" style="width:60%;">
		<thead>
			<tr align="center">
				<td rowspan="2">Место</td>
				<td rowspan="2">Начальный остаток</td>
				<td colspan="2">Приход</td>
				<td colspan="2">Расход</td>
				<td rowspan="2">Конечный остаток</td>
			</tr>
			<tr align="center">
				<td>Поступление</td>
				<td>Перемещение</td>
				<td>Списание</td>
				<td>Перемещение</td>
			</tr>
		</thead>
	
		<tbody>
			<xsl:apply-templates/>
		</tbody>

		<tfoot>
			<tr>
				<td>Итого
				</td>
				
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="sum(row/balance_start)"/>
					</xsl:call-template>																									
				</td>
				
				<td colspan="2" align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="sum(row/total_in)"/>
					</xsl:call-template>																									
				</td>

				<td colspan="2" align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="sum(row/total_out)"/>
					</xsl:call-template>																									
				</td>
				
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="sum(row/balance_end)"/>
					</xsl:call-template>																									
				</td>
			</tr>
		</tfoot>
		
	</table>
</xsl:template>


<xsl:template match="model[@id='RepBalanceList']/row">
	<tr>
		<td><xsl:value-of select="cash_location_name"/>
		</td>
		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="balance_start"/>
			</xsl:call-template>																									
		</td>	
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total_in"/>
			</xsl:call-template>																									
		</td>	
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total_transfer_in"/>
			</xsl:call-template>																									
		</td>	
		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total_transfer_out"/>
			</xsl:call-template>																									
		</td>	
		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total_out"/>
			</xsl:call-template>																									
		</td>	
		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="balance_end"/>
			</xsl:call-template>																									
		</td>	

	</tr>
	<!--
	<xsl:for-each select="/document/model[@id='RepOutList']/row">
	<tr>
		<td colspan="2"></td>
		<td colspan="2">
			<xsl:value-of select="fin_expense_type1_descr"/>
		</td>
		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total_out"/>
			</xsl:call-template>																									
		</td>	
		
		<td></td>
	</tr>	
	</xsl:for-each>
	-->
	
</xsl:template>

</xsl:stylesheet>

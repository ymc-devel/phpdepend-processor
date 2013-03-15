<!--
    phpdepend-processor

    Makes PHPDepend code metrics readable

    @author     Frank Neff <frank.neff@ymc.ch>
    @since      2013-03-15
    @license    MIT (see license.md)
    @source     https://github.com/ymc-devel/phpdepend-processor
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="html" indent="yes"/>

    <xsl:template match="PDepend">
        <html>
            <head>
                <title>PHPDepend analysis</title>

                <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.0/css/bootstrap-combined.min.css"
                      rel="stylesheet"/>
            </head>
            <body style="padding-top: 40px;">

                <div class="navbar navbar-fixed-top">
                    <div class="navbar-inner">
                        <a class="brand" href="#">PHPDepend</a>
                        <ul class="nav">
                            <li>
                                <a href="#summary">Summary</a>
                            </li>
                            <li>
                                <a href="#packages">Packages</a>
                            </li>
                            <li>
                                <a href="#cycles">Cycles</a>
                            </li>
                            <li>
                                <a href="#explanations">Explanations</a>
                            </li>
                        </ul>
                        <ul class="nav pull-right">
                            <li>
                                <a href="http://www.ymc.ch" target="_blank">YMC</a>
                            </li>
                            <li class="divider-vertical"></li>
                            <li>
                                <a href="http://pdepend.org/" target="_blank">PHPDepend</a>
                            </li>
                            <li class="divider-vertical"></li>
                            <li>
                                <a href="https://github.com/ymc-devel/phpdepend-processor" target="_blank">Github</a>
                            </li>

                        </ul>
                    </div>
                </div>

                <div class="container-fluid">

                    <div id="summary" style="padding-top: 40px;"></div>
                    <div class="page-header">
                        <h1>Summary</h1>
                    </div>
                    <table class="table table-striped table-condensed">
                        <tr>
                            <th>Package</th>
                            <th>Total Classes</th>
                            <th>
                                <a href="#EXnumber">Abstract Classes</a>
                            </th>
                            <th>
                                <a href="#EXnumber">Concrete Classes</a>
                            </th>
                            <th>
                                <a href="#EXafferent">Afferent Couplings</a>
                            </th>
                            <th>
                                <a href="#EXefferent">Efferent Couplings</a>
                            </th>
                            <th>
                                <a href="#EXabstractness">Abstractness</a>
                            </th>
                            <th>
                                <a href="#EXinstability">Instability</a>
                            </th>
                            <th>
                                <a href="#EXdistance">Distance</a>
                            </th>

                        </tr>
                        <xsl:for-each select="./Packages/Package">
                            <xsl:if test="count(error) = 0">
                                <tr>
                                    <td align="left">
                                        <a>
                                            <xsl:attribute name="href">#collapse_package_<xsl:value-of
                                                select="position()"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="onclick">$('#collapse_package_<xsl:value-of
                                                select="position()"/>').collapse();
                                            </xsl:attribute>
                                            <xsl:value-of select="@name"/>
                                        </a>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/TotalClasses"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/AbstractClasses"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/ConcreteClasses"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/Ca"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/Ce"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/A"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/I"/>
                                    </td>
                                    <td align="right">
                                        <xsl:value-of select="Stats/D"/>
                                    </td>

                                </tr>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:for-each select="./Packages/Package">
                            <xsl:if test="count(error) &gt; 0">
                                <tr>
                                    <td align="left">
                                        <xsl:value-of select="@name"/>
                                    </td>
                                    <td align="left" colspan="8">
                                        <xsl:value-of select="error"/>
                                    </td>
                                </tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>

                    <div id="packages" style="padding-top: 40px;"></div>
                    <div class="page-header">
                        <h1>Packages</h1>
                    </div>
                    <div id="accordion_packages" class="accordion">
                        <xsl:for-each select="./Packages/Package">
                            <xsl:if test="count(error) = 0">

                                <div class="accordion-group">
                                    <div class="accordion-heading">
                                        <a class="accordion-toggle" data-toggle="collapse"
                                           data-parent="#accordion_packages">
                                            <xsl:attribute name="href">#collapse_package_<xsl:value-of
                                                select="position()"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="@name"/>
                                        </a>
                                    </div>
                                    <div class="accordion-body collapse">
                                        <xsl:attribute name="id">collapse_package_<xsl:value-of select="position()"/>
                                        </xsl:attribute>
                                        <div class="accordion-inner">
                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Abstract Classes</th>
                                                    <th>Concrete Classes</th>
                                                    <th>Used by Packages</th>
                                                    <th>Uses Packages</th>
                                                </tr>
                                                <tr>
                                                    <td valign="top" width="25%">
                                                        <xsl:if test="count(AbstractClasses/Class)=0">
                                                            <i>None</i>
                                                        </xsl:if>
                                                        <xsl:for-each select="AbstractClasses/Class">
                                                            <xsl:value-of select="node()"/>
                                                            <br/>
                                                        </xsl:for-each>
                                                    </td>
                                                    <td valign="top" width="25%">
                                                        <xsl:if test="count(ConcreteClasses/Class)=0">
                                                            <i>None</i>
                                                        </xsl:if>
                                                        <xsl:for-each select="ConcreteClasses/Class">
                                                            <xsl:value-of select="node()"/>
                                                            <br/>
                                                        </xsl:for-each>
                                                    </td>
                                                    <td valign="top" width="25%">
                                                        <xsl:if test="count(UsedBy/Package)=0">
                                                            <i>None</i>
                                                        </xsl:if>
                                                        <xsl:for-each select="UsedBy/Package">
                                                            <xsl:value-of select="node()"/>
                                                            <br/>
                                                        </xsl:for-each>
                                                    </td>
                                                    <td valign="top" width="25%">
                                                        <xsl:if test="count(DependsUpon/Package)=0">
                                                            <i>None</i>
                                                        </xsl:if>
                                                        <xsl:for-each select="DependsUpon/Package">
                                                            <xsl:value-of select="node()"/>
                                                            <br/>
                                                        </xsl:for-each>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </xsl:if>
                        </xsl:for-each>
                    </div>

                    <div id="cycles" style="padding-top: 40px;"></div>
                    <div class="page-header">
                        <h1>Cyclic dependancies</h1>
                    </div>

                    <xsl:if test="count(Cycles/Package) = 0">
                        <div class="alert altert-block">
                            <div class="alert alert-success">
                                <button data-dismiss="alert" class="close" type="button">×</button>
                                <strong>Congratulations!</strong>
                                There are no cyclic dependancies...
                            </div>
                        </div>
                        <p>There are no cyclic dependancies.</p>
                    </xsl:if>
                    <xsl:for-each select="Cycles/Package">
                        <div class="alert altert-block">
                            <button type="button" class="close" data-dismiss="alert">x</button>
                            <h5>
                                <xsl:value-of select="@Name"/>
                            </h5>
                            <ul class="unstyled">
                                <xsl:for-each select="Package">
                                    <li>
                                        <i class="icon-arrow-right"></i>
                                        <xsl:value-of select="."/>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </xsl:for-each>

                    <div id="explanations" style="padding-top: 40px;"></div>
                    <div class="page-header">
                        <h1>Explanations</h1>
                    </div>

                    <p>The following explanations are for quick reference and are lifted directly from the original<a
                        href="http://www.clarkware.com/software/JDepend.html">JDepend documentation</a>.
                    </p>

                    <h3>
                        <a name="EXnumber">Number of Classes</a>
                    </h3>
                    <p>The number of concrete and abstract classes (and interfaces) in the package is an indicator of
                        the
                        extensibility of the package.
                    </p>
                    <h3>
                        <a name="EXafferent">Afferent Couplings</a>
                    </h3>
                    <p>The number of other packages that depend upon classes within the package is an indicator of the
                        package's responsibility.
                    </p>
                    <h3>
                        <a name="EXefferent">Efferent Couplings</a>
                    </h3>
                    <p>The number of other packages that the classes in the package depend upon is an indicator of the
                        package's independence.
                    </p>
                    <h3>
                        <a name="EXabstractness">Abstractness</a>
                    </h3>
                    <p>The ratio of the number of abstract classes (and interfaces) in the analyzed package to the total
                        number of classes in the analyzed package.
                    </p>
                    <p>The range for this metric is 0 to 1, with A=0 indicating a completely concrete package and A=1
                        indicating a completely abstract package.
                    </p>
                    <h3>
                        <a name="EXinstability">Instability</a>
                    </h3>
                    <p>The ratio of efferent coupling (Ce) to total coupling (Ce / (Ce + Ca)). This metric is an
                        indicator
                        of the package's resilience to change.
                    </p>
                    <p>The range for this metric is 0 to 1, with I=0 indicating a completely stable package and I=1
                        indicating a completely instable package.
                    </p>
                    <h3>
                        <a name="EXdistance">Distance</a>
                    </h3>
                    <p>The perpendicular distance of a package from the idealized line A + I = 1. This metric is an
                        indicator of the package's balance between abstractness and stability.
                    </p>
                    <p>A package squarely on the main sequence is optimally balanced with respect to its abstractness
                        and
                        stability. Ideal packages are either completely abstract and stable (x=0, y=1) or completely
                        concrete and instable (x=1, y=0).
                    </p>
                    <p>The range for this metric is 0 to 1, with D=0 indicating a package that is coincident with the
                        main
                        sequence and D=1 indicating a package that is as far from the main sequence as possible.
                    </p>

                </div>

                <!-- le js -->
                <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
                <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.0/js/bootstrap.min.js"></script>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

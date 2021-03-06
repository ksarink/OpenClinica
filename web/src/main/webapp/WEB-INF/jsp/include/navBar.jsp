<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<%
    String currentURL = null;
    if (request.getAttribute("javax.servlet.forward.request_uri") != null) {
        currentURL = (String) request.getAttribute("javax.servlet.forward.request_uri");
    }
    if (currentURL != null && request.getQueryString() != null) {
        currentURL += "?" + request.getQueryString();
    }
%>

<script>
    var myContextPath = "${pageContext.request.contextPath}";
    var sessionTimeoutVal = '<%= session.getMaxInactiveInterval() %>';
    console.log("***********************************sessionTimeoutVal:"+ sessionTimeoutVal);
    var userName = "<%= userBean.getName() %>";
    var currentURL = "<%= currentURL %>";
    var crossStorageURL = '<%= session.getAttribute("crossStorageURL")%>';
    console.log("***********************************Getting crossStorage:"+ crossStorageURL);
    var ocAppTimeoutKey = "OCAppTimeout";
    var firstLoginCheck = '<%= session.getAttribute("firstLoginCheck")%>';
    console.log("Firstr time first:" + firstLoginCheck);
    var currentUser = "currentUser";
    var appName = "RT";
</script>

<jsp:useBean scope='session' id='tableFacadeRestore' class='java.lang.String'/>
<c:set var="restore" value="true"/>
<c:if test="${tableFacadeRestore=='false'}"><c:set var="restore" value="false"/></c:if>
<c:set var="profilePage" value="${param.profilePage}"/>
<!-- If Controller Spring based append ../ to urls -->
<c:set var="urlPrefix" value=""/>
<c:set var="requestFromSpringController" value="${param.isSpringController}"/>
<c:set var="requestFromSpringControllerCCV" value="${param.isSpringControllerCCV}"/>
<c:choose>
    <c:when test="${requestFromSpringController == 'true' || requestFromSpringControllerCCV == 'true'}">
        <c:set var="urlPrefix" value="${pageContext.request.contextPath}/"/>
        <script type="text/JavaScript" language="JavaScript" src="../includes/jmesa/jquery.min.js"></script>
        <script type="text/javascript" language="JavaScript" src="../includes/jmesa/jquery.blockUI.js"></script>
        <link rel="stylesheet" href="../includes/css/icomoon-style.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bluebird/3.3.4/bluebird.min.js"></script>
        <script type="text/javascript" src="../js/lib/es6-promise.auto.min.js"></script>
        <script type="text/javascript" src="../js/lib/client.js"></script>
        <script type="text/javascript">
            var storage = new CrossStorageClient(crossStorageURL);
        </script>
        <script type="text/javascript" language="JavaScript" src="../includes/sessionTimeout.js"></script>
        <script type="text/javascript" language="JavaScript" src="../includes/auth0/captureKeyboardMouseEvents.js"></script>
        <script type="text/javascript">
            console.log("***********************************Getting crossStorage");
            var storage = new CrossStorageClient(crossStorageURL, {
                timeout: 7000
            });
        </script>
        <script type="text/javascript" language="JavaScript" src="../includes/moment.min.js"></script>
    </c:when>
    <c:otherwise>
        <script type="text/JavaScript" language="JavaScript" src="includes/jmesa/jquery.min.js"></script>
        <script type="text/javascript" language="JavaScript" src="includes/jmesa/jquery.blockUI.js"></script>
        <link rel="stylesheet" href="includes/css/icomoon-style.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bluebird/3.3.4/bluebird.min.js"></script>
        <script type="text/javascript" src="js/lib/es6-promise.auto.min.js"></script>
        <script type="text/javascript" src="js/lib/client.js"></script>
        <script type="text/javascript">
            var storage = new CrossStorageClient(crossStorageURL, {
                timeout: 7000});
        </script>
        <script type="text/javascript" language="JavaScript" src="includes/sessionTimeout.js"></script>
        <script type="text/javascript" language="JavaScript" src="includes/auth0/captureKeyboardMouseEvents.js"></script>
        <script type="text/javascript" language="JavaScript" src="includes/moment.min.js"></script>
    </c:otherwise>
</c:choose>


<script type="text/javascript">

    var realInterval = 60;
    if (sessionTimeoutVal < realInterval)
        realInterval = sessionTimeoutVal;
    /**
     * Self-adjusting interval to account for drifting
     *
     * @param {function} workFunc  Callback containing the work to be done
     *                             for each interval
     * @param {int}      interval  Interval speed (in milliseconds) - This
     * @param {function} errorFunc (Optional) Callback to run if the drift
     *                             exceeds interval
     */
    /*
    function AdjustingInterval(workFunc, interval, errorFunc) {
        var that = this;
        var expected, timeout;
        this.interval = interval;

        this.start = function() {
            expected = moment().valueOf() + this.interval;
            timeout = setTimeout(step, this.interval);
        }

        this.stop = function() {
            clearTimeout(timeout);
        }

        function step() {
            var drift = moment().valueOf() - expected;
            if (drift > that.interval) {
                // You could have some default stuff here too...
                if (errorFunc) errorFunc();
            }
            workFunc();
            expected += that.interval;
            timeout = setTimeout(step, Math.max(0, that.interval-drift));
        }
    }
    var doWork = function () {
        processTimedOuts(true, false);
    };
    // Define what to do if something goes wrong
    var doError = function() {
        console.warn('The drift exceeded the interval.');
    };

    var ticker = new AdjustingInterval(doWork, realInterval * 1000, doError);
    ticker.start();
    */
    setInterval(function () {
            processTimedOuts(true, false);
        },
        realInterval * 1000
    );

</script>

<script type="text/javaScript">
    processTimedOuts(true, false);
    //Piwik
    var _paq = _paq || [];
    /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
    _paq.push(["setDocumentTitle", document.domain + "/" + document.title]);
    _paq.push(['trackPageView']);
    _paq.push(['enableLinkTracking']);
    (function() {
    var u='<c:out value="${sessionScope.piwikURL}" />';
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
    })();


    // Walkme snippet
    (function () {
        var walkme = document.createElement('script');
        walkme.type = 'text/javascript';
        walkme.async = true;
        walkme.src = '<c:out value="${sessionScope.walkmeURL}" />';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(walkme, s);
        window._walkmeConfig = {
            smartLoad: true
        };
    })();

    function confirmCancel(pageName) {
        var confirm1 = confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>');
        if (confirm1) {
            window.location = pageName;
        }
    }

    function confirmExit(pageName) {
        var confirm1 = confirm('<fmt:message key="sure_to_exit" bundle="${resword}"/>');
        if (confirm1) {
            window.location = pageName;
        }
    }

    function goBack() {
        var confirm1 = confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>');
        if (confirm1) {
            return history.go(-1);
        }
    }

    function lockedCRFAlert(userName) {
        alert('<fmt:message key="CRF_unavailable" bundle="${resword}"/>' + '\n'
            + '          ' + userName + ' ' + '<fmt:message key="Currently_entering_data" bundle="${resword}"/>' + '\n'
            + '<fmt:message key="Leave_the_CRF" bundle="${resword}"/>');
        return false;
    }

    function confirmCancelAction(pageName, contextPath) {
        var confirm1 = confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>');
        if (confirm1) {
            var tform = document.forms["fr_cancel_button"];
            tform.action = contextPath + "/" + pageName;
            tform.submit();

        }
    }

    function confirmExitAction(pageName, contextPath) {
        var confirm1 = confirm('<fmt:message key="sure_to_exit" bundle="${resword}"/>');
        if (confirm1) {
            var tform = document.forms["fr_cancel_button"];
            tform.action = contextPath + "/" + pageName;
            tform.submit();

        }
    }

    function processLogoutClick(returnTo) {
        setCurrentUser("");
    }
</script>

<!-- Main Navigation -->
<div class="oc_nav">
    <div class="nav-top-bar">
        <!-- Logo -->

        <div class="logo">
            <c:set var="isLogo"/>
            <c:set var="isHref"/>

            <c:if test="${param.isSpringController}">
                <c:set var="isHref" value="../MainMenu"/>
                <c:set var="isLogo" value="../images/logo-color-on-dark.svg"/>
            </c:if>

            <c:if test="${param.isSpringControllerCCV}">
                <c:set var="isHref" value="../../MainMenu"/>
                <c:set var="isLogo" value="../../images/logo-color-on-dark.svg"/>
            </c:if>

            <c:if test="${!param.isSpringController}">
                <c:set var="isHref" value="MainMenu"/>
                <c:set var="isLogo" value="images/logo-color-on-dark.svg"/>
            </c:if>

            <a href="${isHref}"><img src="${isLogo}" alt="OpenClinica Logo"/></a>
        </div>

        <div id="StudyInfo">
            <c:choose>
                <c:when test='${study.parentStudyId > 0}'>
                    <b><a href="${urlPrefix}ViewStudy?id=${study.parentStudyId}&viewFull=yes"
                        title="<c:out value='${study.parentStudyName}'/>"
                        alt="<c:out value='${study.parentStudyName}'/>" ><c:out value="${study.abbreviatedParentStudyName}" /></a>
                        :&nbsp;<a href="${urlPrefix}ViewSite?id=${study.id}" title="<c:out value='${study.name}'/>" alt="<c:out value='${study.name}'/>"><c:out value="${study.abbreviatedName}" /></a></b>
                </c:when>
                <c:otherwise>
                    <b><a href="${urlPrefix}ViewStudy?id=${study.id}&viewFull=yes" title="<c:out value='${study.name}'/>" alt="<c:out value='${study.name}'/>"><c:out value="${study.abbreviatedName}" /></a></b>
                </c:otherwise>
            </c:choose>
            (<c:out value="${study.abbreviatedIdentifier}" />)&nbsp;&nbsp;
            <c:if test="${study.envType == 'PROD'}">
                <c:if test="${study.status.pending}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="design" bundle="${resword}"/></span>
                </c:if>
                <c:if test="${study.status.locked}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="locked" bundle="${resword}"/></span>
                </c:if>
                <c:if test="${study.status.frozen}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="frozen" bundle="${resword}"/></span>
                </c:if>
            </c:if>
            <c:if test="${study.envType == 'TEST'}">
                <c:if test="${study.status.pending}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="test_environment" bundle="${resword}"/> | <fmt:message key="design" bundle="${resword}"/></span>
                </c:if>
                <c:if test="${study.status.locked}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="test_environment" bundle="${resword}"/> | <fmt:message key="locked" bundle="${resword}"/></span>
                </c:if>
                <c:if test="${study.status.frozen}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="test_environment" bundle="${resword}"/> | <fmt:message key="frozen" bundle="${resword}"/></span>
                </c:if>
                <c:if test="${study.status.available}">
                    <span class="status-tag status-${fn:toLowerCase(study.envType)}"><fmt:message key="test_environment" bundle="${resword}"/></span>
                </c:if>
            </c:if>&nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="${urlPrefix}ChangeStudy"><fmt:message key="change" bundle="${resword}"/></a>
        </div>

        <div id="UserInfo">
            <div id="userDropdown">
                <ul>
                    <li><a href="#"><b><c:out value="${userBean.name}"/></b> (<c:out value="${userRole.role.description}"/>)<span
                            class="icon icon-caret-down white"></span></a></a>
                        <!-- First Tier Drop Down -->
                        <ul class="dropdown_BG">
                            <c:if test="${userBean.sysAdmin || userBean.techAdmin || userRole.coordinator}">
                                <li><a href="${study.manager}"><fmt:message key="return_to_my_studies" bundle="${resworkflow}"/></a></li>
                            </c:if>
                            <li>
                                <a href="${(study.manager).replace('account-study','my-profile')}?returnTo=${currentPageUrl}"><fmt:message key="return_to_my_profile" bundle="${resworkflow}"/></a></li>
                            <c:if test="${userBean.sysAdmin || userBean.techAdmin}">
                                <li>
                                    <a href="${(study.manager).replace('account-study','admin')}"><fmt:message key="return_to_admin" bundle="${resworkflow}"/></a>
                                </li>
                            </c:if>
                            <li>
                                <a href="javascript:openDocWindow('<c:out value="${sessionScope.supportURL}" />')"><fmt:message key="openclinica_feedback" bundle="${resword}"/></a>
                            </li>
                            <li>
                                <a onClick="javascript:processLogoutClick('<%=currentURL%>');" href="${urlPrefix}pages/logout"><fmt:message key="sign_out" bundle="${resworkflow}"/></a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="box_T">
        <div class="box_L">
            <div class="box_R">
                <div class="box_B">
                    <div class="box_TL">
                        <div class="box_TR">
                            <div class="box_BL">
                                <div class="box_BR">

                                    <div class="navbox_center">
                                        <!-- Top Navigation Row -->
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <div id="bt_Home" class="nav_bt">
                                                        <div>
                                                            <div>
                                                                <div>
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <form METHOD="GET" action="${urlPrefix}ListStudySubjects"
                                                                                      onSubmit=" if (document.forms[0]['findSubjects_f_studySubject.label'].value == '
                                                                                      <fmt:message key="study_subject_ID"
                                                                                                   bundle="${resword}"/>') { document.forms[0]['findSubjects_f_studySubject.label'].value=''}">
                                                                                    <!--<a href="javascript:reportBug()">Report Issue</a>|-->
                                                                                    <input type="text" name="findSubjects_f_studySubject.label"
                                                                                           onblur="if (this.value == '') this.value = '<fmt:message
                                                                                                   key="study_subject_ID" bundle="${resword}"/>'"
                                                                                           onfocus="if (this.value == '<fmt:message key="study_subject_ID"
                                                                                                                                    bundle="${resword}"/>') this.value = ''"
                                                                                           value='<fmt:message key="study_subject_ID" bundle="${resword}"/>'
                                                                                           class="navSearch"/>
                                                                                    <input type="hidden" name="navBar" value="yes"/>
                                                                                    <input type="submit" value="View &#8594;" class="navSearchButton"/>
                                                                                </form>
                                                                            </td>
                                                                            <td align="right" style="font-weight: normal;">
                                                                                <ul>
                                                                                    <c:if test="${userRole.coordinator || userRole.director}">
                                                                                        <li><a href="${urlPrefix}MainMenu"><fmt:message key="nav_home"
                                                                                                                                        bundle="${resword}"/></a>
                                                                                        </li>
                                                                                        <li><a href="${urlPrefix}ListStudySubjects"><fmt:message
                                                                                                key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                                                                        <li><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message
                                                                                                key="queries" bundle="${resword}"/></a></li>
                                                                                        <li><a href="${urlPrefix}StudyAuditLog"><fmt:message
                                                                                                key="nav_study_audit_log" bundle="${resword}"/></a></li>
                                                                                    </c:if>
                                                                                    <c:if test="${userRole.researchAssistant ||userRole.researchAssistant2}">
                                                                                        <li><a href="${urlPrefix}MainMenu"><fmt:message key="nav_home"
                                                                                                                                        bundle="${resword}"/></a>
                                                                                        </li>
                                                                                        <li><a href="${urlPrefix}ListStudySubjects"><fmt:message
                                                                                                key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                                                                        <c:if test="${study.status.available}">
                                                                                            <li><a href="javascript:;" id="navAddSubject"><fmt:message
                                                                                                    key="nav_add_subject" bundle="${resword}"/></a></li>
                                                                                        </c:if>
                                                                                        <li><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message
                                                                                                key="queries" bundle="${resword}"/></a></li>
                                                                                    </c:if>
                                                                                    <c:if test="${userRole.investigator}">
                                                                                        <li><a href="${urlPrefix}MainMenu"><fmt:message key="nav_home"
                                                                                                                                        bundle="${resword}"/></a>
                                                                                        </li>
                                                                                        <li><a href="${urlPrefix}ListStudySubjects"><fmt:message
                                                                                                key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                                                                        <c:if test="${study.status.available}">
                                                                                            <li><a href="javascript:;" id="navAddSubject"><fmt:message
                                                                                                    key="nav_add_subject" bundle="${resword}"/></a></li>
                                                                                        </c:if>
                                                                                        <li><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message
                                                                                                key="queries" bundle="${resword}"/></a></li>
                                                                                    </c:if>
                                                                                    <c:if test="${userRole.monitor }">
                                                                                        <li><a href="${urlPrefix}MainMenu"><fmt:message key="nav_home"
                                                                                                                                        bundle="${resword}"/></a>
                                                                                        </li>
                                                                                        <li><a href="${urlPrefix}ListStudySubjects"><fmt:message
                                                                                                key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                                                                        <li>
                                                                                            <a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}"><fmt:message
                                                                                                    key="nav_sdv" bundle="${resword}"/></a></li>
                                                                                        <li><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message
                                                                                                key="queries" bundle="${resword}"/></a></li>
                                                                                    </c:if>
                                                                                    <li class="nav_TaskB" id="nav_Tasks" style="position: relative; z-index: 1;">
                                                                                        <a href="#" onmouseover="setNav('nav_Tasks');"
                                                                                           id="nav_Tasks_link"><fmt:message key="nav_tasks"
                                                                                                                            bundle="${resword}"/>
                                                                                            <span class="icon icon-caret-down white"></span></a>
                                                                                    </li>
                                                                                </ul>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <!-- End shaded box border DIVs -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</td>
</tr>
</table>
<!-- NAVIGATION DROP-DOWN -->

<div id="nav_hide" style="position: absolute; left: 0px; top: 0px; visibility: hidden; z-index: -1; width: 100%; height: 400px;">

    <a href="#" onmouseover="hideSubnavs();">
        <c:choose>
            <c:when test="${requestFromSpringController == 'true' || requestFromSpringControllerCCV == 'true'}">
                <img src="../images/spacer.gif" alt="" width="1000" height="400" border="0"/>
            </c:when>
            <c:otherwise>
                <img src="images/spacer.gif" alt="" width="1000" height="400" border="0"/>
            </c:otherwise>
        </c:choose>
    </a>
</div>


</div>
<c:choose>
    <c:when test="${requestFromSpringController == 'true' || requestFromSpringControllerCCV == 'true'}">
        <img src="../images/spacer.gif" width="596" height="1"><br>
    </c:when>
    <c:otherwise>
        <img src="images/spacer.gif" width="596" height="1"><br>
    </c:otherwise>
</c:choose>
<!-- End Main Navigation -->
<div id="subnav_Tasks" class="dropdown">
    <div class="dropdown_BG">
        <c:if test="${userRole.monitor }">
            <div class="taskGroup"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}ListStudySubjects"><fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></div>
                <div class="taskLink"><a href="${urlPrefix}ViewStudyEvents"><fmt:message key="nav_view_events" bundle="${resword}"/></a></div>
                <div class="taskLink"><a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}"><fmt:message
                        key="nav_source_data_verification" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <div class="taskLink"><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message key="queries" bundle="${resword}"/></a></div>
                <div class="taskLink"><a href="${urlPrefix}StudyAuditLog"><fmt:message key="nav_study_audit_log" bundle="${resword}"/></a></div>
            </div>
            <br clear="all">
            <div class="taskGroup"><fmt:message key="nav_extract_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}ViewDatasets"><fmt:message key="nav_view_datasets" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <div class="taskLink"><a href="${urlPrefix}CreateDataset"><fmt:message key="nav_create_dataset" bundle="${resword}"/></a></div>
            </div>
            <br clear="all">
        </c:if>
        <c:if test="${userRole.researchAssistant ||userRole.researchAssistant2  }">
            <div class="taskGroup"><fmt:message key="nav_submit_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}ListStudySubjects"><fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></div>
                <c:if test="${study.status.available}">
                    <div class="taskLink"><a href="javascript:;" id="navAddSubjectSD"><fmt:message key="nav_add_subject" bundle="${resword}"/></a></div>
                </c:if>
                <div class="taskLink"><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message key="queries" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <c:if test="${!study.status.frozen && !study.status.locked}">
                    <div class="taskLink"><a href="${urlPrefix}CreateNewStudyEvent"><fmt:message key="nav_schedule_event" bundle="${resword}"/></a></div>
                </c:if>
                <div class="taskLink"><a href="${urlPrefix}ViewStudyEvents"><fmt:message key="nav_view_events" bundle="${resword}"/></a></div>
                <c:if test="${study.status.available}">
                    <div class="taskLink"><a href="${urlPrefix}ImportCRFData"><fmt:message key="nav_import_data" bundle="${resword}"/></a></div>
                </c:if>
            </div>
            <br clear="all">
        </c:if>
        <c:if test="${userRole.investigator}">
            <div class="taskGroup"><fmt:message key="nav_submit_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}ListStudySubjects"><fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></div>
                <c:if test="${study.status.available}">
                    <div class="taskLink"><a href="javascript:;" id="navAddSubjectSD"><fmt:message key="nav_add_subject" bundle="${resword}"/></a></div>
                </c:if>
                <div class="taskLink"><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message key="queries" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <c:if test="${!study.status.frozen && !study.status.locked}">
                    <div class="taskLink"><a href="${urlPrefix}CreateNewStudyEvent"><fmt:message key="nav_schedule_event" bundle="${resword}"/></a></div>
                </c:if>
                <div class="taskLink"><a href="${urlPrefix}ViewStudyEvents"><fmt:message key="nav_view_events" bundle="${resword}"/></a></div>
                <c:if test="${study.status.available}">
                <div class="taskLink"><a href="${urlPrefix}ImportCRFData"><fmt:message key="nav_import_data" bundle="${resword}"/></a></div>
            </c:if>
            </div>
            <br clear="all">
            <div class="taskGroup"><fmt:message key="nav_extract_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}ViewDatasets"><fmt:message key="nav_view_datasets" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <div class="taskLink"><a href="${urlPrefix}CreateDataset"><fmt:message key="nav_create_dataset" bundle="${resword}"/></a></div>
            </div>
            <br clear="all">
        </c:if>
        <c:if test="${userRole.coordinator || userRole.director}">
            <div class="taskGroup"><fmt:message key="nav_submit_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}ListStudySubjects"><fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></div>
                <c:if test="${study.status.available}">
                    <div class="taskLink"><a href="javascript:;" id="navAddSubjectSD"><fmt:message key="nav_add_subject" bundle="${resword}"/></a></div>
                </c:if>
                <div class="taskLink"><a href="${urlPrefix}ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.disType=Query"><fmt:message key="queries" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <c:if test="${!study.status.frozen && !study.status.locked}">
                    <div class="taskLink"><a href="${urlPrefix}CreateNewStudyEvent"><fmt:message key="nav_schedule_event" bundle="${resword}"/></a></div>
                </c:if>
                <div class="taskLink"><a href="${urlPrefix}ViewStudyEvents"><fmt:message key="nav_view_events" bundle="${resword}"/></a></div>
            <c:if test="${study.status.available}">
                <div class="taskLink"><a href="${urlPrefix}ImportCRFData"><fmt:message key="nav_import_data" bundle="${resword}"/></a></div>
            </c:if>
            </div>
            <br clear="all">
            <div class="taskGroup"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}StudyAuditLog"><fmt:message key="nav_study_audit_log" bundle="${resword}"/></a></div>
                <div class="taskLink"><a href="${urlPrefix}ViewRuleAssignment?read=true"><fmt:message key="nav_rules" bundle="${resword}"/></a>
                </div>
                <c:choose>
                    <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                    </c:when>
                    <c:otherwise>
                        <div class="taskLink"><a href="${urlPrefix}ViewStudy?id=${study.id}&viewFull=yes"><fmt:message key="nav_view_study"
                                                                                                                       bundle="${resword}"/></a></div>
                        <div class="taskLink"></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="taskRightColumn">
                <c:choose>
                    <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                    </c:when>
                    <c:otherwise>
                        <div class="taskLink"><a href="${urlPrefix}ListSite?read=true"><fmt:message key="nav_sites" bundle="${resword}"/></a></div>
                        <div class="taskLink"><a href="${urlPrefix}ListCRF?module=manage"><fmt:message key="nav_crfs" bundle="${resword}"/></a></div>
                        <div class="taskLink"><a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}"><fmt:message
                                key="nav_source_data_verification" bundle="${resword}"/></a><br/></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <br clear="all">
            <div class="taskGroup"><fmt:message key="nav_extract_data" bundle="${resword}"/></div>
            <div class="taskLeftColumn">
                <div class="taskLink"><a href="${urlPrefix}CreateDataset"><fmt:message key="nav_create_dataset" bundle="${resword}"/></a></div>
            </div>
            <div class="taskRightColumn">
                <div class="taskLink"><a href="${urlPrefix}ViewDatasets"><fmt:message key="nav_view_datasets" bundle="${resword}"/></a></div>
            </div>
            <br clear="all">
        </c:if>
    </div>
</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery('#navAddSubject').click(function () {
            jQuery.blockUI({message: jQuery('#navAddSubjectForm'), css: {left: "300px", top: "10px"}});
        });

        jQuery('#cancel').click(function () {
            jQuery.unblockUI();
            return false;
        });
    });
    jQuery(document).ready(function () {
        jQuery('#navAddSubjectSD').click(function () {
            jQuery.blockUI({message: jQuery('#navAddSubjectForm'), css: {left: "300px", top: "10px"}});
        });

        jQuery('#cancel').click(function () {
            jQuery.unblockUI();
            return false;
        });
    });

    dropdown = document.getElementById("subnav_Tasks");

    //close dropdown using esc
    $(document).keyup(function(e) {
        if (e.keyCode == 27) { // escape key maps to keycode `27`
            dropdown.style.display="none";
        }
    });

    //we have it open on mouse-over OR click when it is closed
    $(document).ready(function(){
        // Show hide popover
        $(".nav_TaskB").click(function(){
            $(this).find(".dropdown").slideToggle("fast");
        });
    });
    $(document).on("click", function(event){
        var $trigger = $(".nav_TaskB");
        if($trigger !== event.target && !$trigger.has(event.target).length){
            $(".dropdown").slideUp("fast");
        }
    });
    function showDropdown() {
        if (dropdown.style.display === 'none') {
            dropdown.style.display = 'block';
        } else {
            droopdown.style.display = 'none';
        }
    }
</script>

<div id="navAddSubjectForm" style="display: none">
    <form name="subjectForm" action="AddNewSubject" method="post">
        <input type="hidden" name="subjectOverlay" value="true">

        <table border="0" cellpadding="0" align="center" style="cursor:default;">
            <tr style="height:10px;">
                <td class="formlabel" align="left"><h3 class="addNewSubjectTitle"><fmt:message key="add_new_subject" bundle="${resword}"/></h3></td>
            </tr>
            <tr>
                <td>
                    <div class="lines"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="max-height: 550px; min-width:400px; background:#FFFFFF; overflow-y: auto;">
                        <table>
                            <tr valign="top">
                                <td class="formlabel" align="left">
                                    <jsp:include page="../include/showSubmitted.jsp"/>
                                    <input class="form-control" type="hidden" name="addWithEvent" value="1"/><span class="addNewStudyLayout">
                                <fmt:message key="study_subject_ID" bundle="${resword}"/></span>&nbsp;<small class="required">*</small>
                                </td>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                        <tr>
                                            <td valign="top">
                                                <div class="formfieldXL_BG">
                                                    <c:choose>
                                                        <c:when test="${study.studyParameterConfig.subjectIdGeneration =='auto non-editable'}">
                                                            <input onfocus="this.select()" type="text" value="<c:out value="${label}"/>" size="45"
                                                                   class="formfield form-control" disabled>
                                                            <input class="form-control" type="hidden" name="label" value="<c:out value="${label}"/>">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input onfocus="this.select()" type="text" name="label" value="<c:out value="${label}"/>" width="30"
                                                                   class="formfieldXL form-control">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <jsp:include page="../showMessage.jsp">
                                                    <jsp:param name="key" value="label"/>
                                                </jsp:include>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>

                            <c:choose>
                                <c:when test="${study.studyParameterConfig.subjectPersonIdRequired =='required'}">
                                    <tr valign="top">
                                        <td class="formlabel" align="left">
                                            <span class="addNewStudyLayout"><fmt:message key="person_ID" bundle="${resword}"/></span>&nbsp;<small
                                                class="required">*
                                        </small>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                                <tr>
                                                    <td valign="top">
                                                        <div class="formfieldXL_BG">
                                                            <input onfocus="this.select()" type="text" name="uniqueIdentifier"
                                                                   value="<c:out value="${uniqueIdentifier}"/>" width="30" class="formfieldXL form-control">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <jsp:include page="../showMessage.jsp">
                                                            <jsp:param name="key" value="uniqueIdentifier"/>
                                                        </jsp:include>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:when test="${study.studyParameterConfig.subjectPersonIdRequired =='optional'}">
                                    <tr valign="top">
                                        <td class="formlabel" align="left">
                                            <span class="addNewStudyLayout"><fmt:message key="person_ID" bundle="${resword}"/></span>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                                <tr>
                                                    <td valign="top">
                                                        <div class="formfieldXL_BG">
                                                            <input onfocus="this.select()" type="text" name="uniqueIdentifier"
                                                                   value="<c:out value="${uniqueIdentifier}"/>" width="30" class="formfieldXL form-control">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <jsp:include page="../showMessage.jsp">
                                                            <jsp:param name="key" value="uniqueIdentifier"/>
                                                        </jsp:include>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>">
                                </c:otherwise>
                            </c:choose>

                            <tr valign="top">
                                <td class="formlabel" align="left">
                                    <span class="addNewStudyLayout"><fmt:message key="secondary_ID" bundle="${resword}"/></span>
                                </td>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                        <tr>
                                            <td valign="top">
                                                <div class="formfieldXL_BG">
                                                    <input onfocus="this.select()" type="text" name="secondaryLabel" value="<c:out value="${secondaryLabel}"/>"
                                                           width="30" class="formfieldXL form-control">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <jsp:include page="../showMessage.jsp">
                                                    <jsp:param name="key" value="secondaryLabel"/>
                                                </jsp:include>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr valign="top">
                                <td class="formlabel" align="left">
                                    <span class="addNewStudyLayout"><fmt:message key="enrollment_date" bundle="${resword}"/></span>&nbsp;<small
                                        class="required">*
                                </small>
                                </td>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                        <tr>
                                            <td>
                                                <input onfocus="this.select()" type="text" name="enrollmentDate" size="16"
                                                       value="<c:out value="${enrollmentDate}" />" class="formfieldM form-control"
                                                       id="enrollmentDateField_${rand}"/>
                                            </td>
                                            <td valign="top" class="icon-container">
                                                <a href="#">
                                                    <span class="icon icon-calendar" alt="<fmt:message key="show_calendar" bundle="${resword}"/>"
                                                          title="<fmt:message key="show_calendar" bundle="${resword}"/>" border="0"
                                                          id="enrollmentDateTrigger_${rand}"/>
                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: "enrollmentDateField_${rand}",
                                                            ifFormat: "<fmt:message key="date_format_calender" bundle="${resformat}"/>",
                                                            button: "enrollmentDateTrigger_${rand}",
                                                            customPX: 300,
                                                            customPY: 10,
                                                            randomize: "${rand}"
                                                        });
                                                    </script>
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <jsp:include page="../showMessage.jsp">
                                                    <jsp:param name="key" value="enrollmentDate"/>
                                                </jsp:include>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr valign="top">
                                <c:if test="${study.studyParameterConfig.genderRequired !='not used'}">
                                    <td class="formlabel" align="left">
                                        <span class="addNewStudyLayout"><fmt:message key="gender" bundle="${resword}"/></span>
                                        <c:choose>
                                            <c:when test="${study.studyParameterConfig.genderRequired !='false'}">
                                                &nbsp;<small class="required">*</small>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td valign="top">
                                                    <div class="selectS">
                                                        <select name="gender">
                                                            <option value="">-<fmt:message key="select" bundle="${resword}"/>-</option>
                                                            <c:choose>
                                                                <c:when test="${!empty chosenGender}">
                                                                    <c:choose>
                                                                        <c:when test='${chosenGender == "m"}'>
                                                                            <option value="m" selected><fmt:message key="male" bundle="${resword}"/></option>
                                                                            <option value="f"><fmt:message key="female" bundle="${resword}"/></option>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <option value="m"><fmt:message key="male" bundle="${resword}"/></option>
                                                                            <option value="f" selected><fmt:message key="female" bundle="${resword}"/></option>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="m"><fmt:message key="male" bundle="${resword}"/></option>
                                                                    <option value="f"><fmt:message key="female" bundle="${resword}"/></option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </select></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <jsp:include page="../showMessage.jsp">
                                                        <jsp:param name="key" value="gender"/>
                                                    </jsp:include>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </c:if>
                            </tr>


                            <c:choose>
                                <c:when test="${study.studyParameterConfig.collectDob == '1'}">
                                    <tr valign="top">
                                        <td class="formlabel" align="left"><span class="addNewStudyLayout"><fmt:message key="date_of_birth"
                                                                                                                        bundle="${resword}"/></span>&nbsp;<small
                                                class="required">*
                                        </small>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                                <tr>
                                                    <td>
                                                        <input onfocus="this.select()" type="text" name="dob" size="16" value="<c:out value="${dob}" />"
                                                               class="formfieldM form-control" id="dobField_${rand}"/>
                                                    </td>
                                                    <td valign="top" class="icon-container">
                                                        <a href="#">
                                                            <span class="icon icon-calendar" alt="<fmt:message key="show_calendar" bundle="${resword}"/>"
                                                                  title="<fmt:message key="show_calendar" bundle="${resword}"/>" border="0"
                                                                  id="dobTrigger_${rand}"/>
                                                            <script type="text/javascript">
                                                                Calendar.setup({
                                                                    inputField: "dobField_${rand}",
                                                                    ifFormat: "<fmt:message key="date_format_calender" bundle="${resformat}"/>",
                                                                    button: "dobTrigger_${rand}",
                                                                    customPX: 300,
                                                                    customPY: 10,
                                                                    randomize: "${rand}"
                                                                });
                                                            </script>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <jsp:include page="../showMessage.jsp">
                                                            <jsp:param name="key" value="dob"/>
                                                        </jsp:include>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </c:when>
                                <c:when test="${study.studyParameterConfig.collectDob == '2'}">
                                    <tr valign="top">
                                        <td class="formlabel" align="left"><span class="addNewStudyLayout"><fmt:message key="year_of_birth"
                                                                                                                        bundle="${resword}"/></span>&nbsp;<small
                                                class="required">*
                                        </small>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                                <tr>
                                                    <td valign="top">
                                                        <div class="formfieldM_BG">
                                                            <input onfocus="this.select()" type="text" name="yob" size="15" value="<c:out value="${yob}" />"
                                                                   class="formfieldM form-control"/>
                                                    </td>
                                                    <td class="formlabel" align="left">(<fmt:message key="date_format_year" bundle="${resformat}"/>)</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <jsp:include page="../showMessage.jsp">
                                                            <jsp:param name="key" value="yob"/>
                                                        </jsp:include>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="dob" value=""/>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${(!empty studyGroupClasses)}">
                                <tr valign="top">
                                    <td class="formlabel" align="left"><span class="addNewStudyLayout"><fmt:message key="subject_group_class"
                                                                                                                    bundle="${resword}"/></span>
                                    <td class="table_cell">
                                        <c:set var="count" value="0"/>
                                        <table border="0" cellpadding="0">
                                            <c:forEach var="group" items="${studyGroupClasses}">
                                                <tr valign="top">
                                                    <td><b><c:out value="${group.name}"/></b></td>
                                                    <td>
                                                        <div class="formfieldM_BG">
                                                            <select name="studyGroupId<c:out value="${count}"/>" class="formfieldM">
                                                                <option value=""><c:out value="${group.name}"/>:</option>
                                                                <c:forEach var="studyGroup" items="${group.studyGroups}">
                                                                    <option value="<c:out value="${studyGroup.id}"/>"><c:out
                                                                            value="${studyGroup.name}"/></option>
                                                                </c:forEach>
                                                            </select></div>
                                                        <c:import url="../showMessage.jsp"><c:param name="key" value="studyGroupId${count}"/></c:import>

                                                    </td>
                                                    <c:if test="${group.subjectAssignment=='Required'}">
                                                        <td align="left">&nbsp;*</td>
                                                    </c:if>
                                                </tr>
                                                <c:set var="count" value="${count+1}"/>
                                            </c:forEach>
                                        </table>
                                    </td>
                                </tr>
                            </c:if>

                            <tr valign="top">
                                <td class="formlabel" align="left"><span class="addNewStudyLayout"><fmt:message key="SED_2" bundle="${resword}"/></span></td>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <div class="selectS">
                                                    <select name="studyEventDefinition" class="formfieldM">
                                                        <option value="">-<fmt:message key="select" bundle="${resword}"/>-</option>
                                                        <c:forEach var="event" items="${allDefsArray}">
                                                            <option
                                                                    <c:if test="${studyEventDefinition == event.id}">SELECTED</c:if>
                                                                    value="<c:out value="${event.id}"/>"><c:out value="${event.name}"/>
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <jsp:include page="../showMessage.jsp">
                                                    <jsp:param name="key" value="studyEventDefinition"/>
                                                </jsp:include>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr valign="top">
                                <td class="formlabel" align="left">
                                    <span class="addNewStudyLayout"><fmt:message key="start_date" bundle="${resword}"/>
                                    <c:if test="${studyEventDefinition > 0}">&nbsp;<small class="required">*</c:if>
                                </small>
                                </td>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                        <tr>
                                            <td>
                                                <input type="text" name="startDate" size="15" value="<c:out value="${startDate}" />"
                                                       class="formfieldM form-control" id="enrollmentDateField2_${rand}"/>
                                            </td>
                                            <td valign="top" class="icon-container">
                                                <a href="#">
                                                    <span class="icon icon-calendar" alt="<fmt:message key="show_calendar" bundle="${resword}"/>"
                                                          title="<fmt:message key="show_calendar" bundle="${resword}"/>" border="0"
                                                          id="enrollmentDateTrigger2_${rand}"/></a>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "enrollmentDateField2_${rand}",
                                                        ifFormat: "<fmt:message key="date_format_calender" bundle="${resformat}"/>",
                                                        button: "enrollmentDateTrigger2_${rand}",
                                                        customPX: 300,
                                                        customPY: 10,
                                                        randomize: "${rand}"
                                                    });
                                                </script>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <jsp:include page="../showMessage.jsp">
                                                    <jsp:param name="key" value="startDate"/>
                                                </jsp:include>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <c:choose>
                                <c:when test="${study.studyParameterConfig.eventLocationRequired == 'required'}">
                                    <tr valign="top">
                                        <td class="formlabel" align="left">
                                            <span class="addNewStudyLayout"><fmt:message key="location" bundle="${resword}"/></span>&nbsp;<small
                                                class="required">*
                                        </small>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                                <tr>
                                                    <td valign="top">
                                                        <div class="formfieldXL_BG">
                                                            <input type="text" name="location" size="50" value="<c:out value="${location}"/>"
                                                                   class="formfieldXL form-control">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <jsp:include page="../showMessage.jsp">
                                                            <jsp:param name="key" value="location"/>
                                                        </jsp:include>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </c:when>
                                <c:when test="${study.studyParameterConfig.eventLocationRequired == 'optional'}">
                                    <tr valign="top">
                                        <td class="formlabel" align="left">
                                            <span class="addNewStudyLayout"><fmt:message key="location" bundle="${resword}"/></span>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" class="full-width">
                                                <tr>
                                                    <td valign="top">
                                                        <div class="formfieldXL_BG">
                                                            <input type="text" name="location" size="50" class="formfieldXL form-control">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="location" value=""/>
                                </c:otherwise>
                            </c:choose>

                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="lines"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <input type="submit" name="addSubject" value="Add"/>
                    &nbsp;
                    <input type="button" id="cancel" name="cancel" value="Cancel"/>

                    <div id="dvForCalander_${rand}" style="width:1px; height:1px;"></div>
                </td>
            </tr>

        </table>

    </form>
</div>

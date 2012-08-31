
// This js is set up by xslt formatting a
// getPassage() reply.  It relies on the 
// CTS-Universal implementation's practice of
// including useful information in the <request>
// element of a CTS service response.
function setUrn() {
  var wkEl = document.getElementById('workUrn');
  var compoundUrn =  wkEl.getAttribute("value") + ":" + document.forms[0].psg.value;
  document.forms[0].urn.value = compoundUrn;


  // delete additional HTML element once we've set up the URN value, so we
  // don't have extraneous HTTP parameters?
  // 
  // still shows up in HTTP parameters.  :-(
  // psgInput.parentNode.removeChild(psgInput);

  return true;
}

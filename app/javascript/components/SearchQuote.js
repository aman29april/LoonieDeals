import React from "react"
import PropTypes from "prop-types"

class SearchQuote extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div class="has-addon left-addon dropdown-typeahead">
          <i class="addon icon-search"></i>
          <input
            aria-label="Search for a company"
            autocomplete="off"
            autofocus="true"
            class="u-full-width"
            data-company-search="true"
            placeholder="Search for a company"
            spellcheck="false"
            style="margin-bottom: 0px;"
            type="search"
          >
            /
          </input>
          <ul class="dropdown-content"></ul>
        </div>
      </React.Fragment>
    );
  }
}

SearchQuote.propTypes = {
  greeting: PropTypes.string
};
export default SearchQuote

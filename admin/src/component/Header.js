function Header() {
  return (
    <header>
      <ul className="dropdown-content" id="user_dropdown">
        <li>
          <a className="indigo-text" href="#!">
            Profile
          </a>
        </li>
        <li>
          <a className="indigo-text" href="#!">
            Logout
          </a>
        </li>
      </ul>

      <nav className="indigo" role="navigation">
        <div className="nav-wrapper">
          <a
            data-activates="slide-out"
            className="button-collapse show-on-"
            href="#!"
          >
            <img
              style={{ marginTop: '17px', marginLeft: '5px' }}
              src="https://res.cloudinary.com/dacg0wegv/image/upload/t_media_lib_thumb/v1463989873/smaller-main-logo_3_bm40iv.gif"
            />
          </a>

          <ul className="right hide-on-med-and-down">
            <li>
              <a
                className="right dropdown-button"
                href=""
                data-activates="user_dropdown"
              >
                <i className="material-icons">account_circle</i>
              </a>
            </li>
          </ul>

          <a href="#" data-activates="slide-out" className="button-collapse">
            <i className="mdi-navigation-menu"></i>
          </a>
        </div>
      </nav>

      <nav>
        <div className="nav-wrapper indigo darken-2">
          <a style={{ marginLeft: '20px' }} className="breadcrumb" href="/">
            Dashboard
          </a>
          {/* <a className="breadcrumb" href="#!">
            Index
          </a> */}

          <div
            style={{ marginRight: '20px' }}
            id="timestamp"
            className="right"
          ></div>
        </div>
      </nav>
    </header>
  );
}

export default Header;

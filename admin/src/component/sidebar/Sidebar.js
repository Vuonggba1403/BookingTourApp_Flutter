import './Sidebar.css';
import avatar from '../../images/godfather.jpg';

function Sidebar() {
  return (
    <ul id="slide-out" className="side-bar side-nav fixed z-depth-2">
      <li className="center no-padding">
        <div className="indigo darken-2 white-text" style={{ height: '180px' }}>
          <div className="row avatar">
            <img
              style={{ marginTop: '5%', objectFit: 'cover' }}
              width="130"
              height="130"
              src={avatar}
              className=""
            />
            <p style={{ marginTop: '-13%' }}>Godfather</p>
          </div>
        </div>
      </li>

      <li id="dash_dashboard">
        <a className="waves-effect" href="/">
          <b>Dashboard</b>
        </a>
      </li>

      <ul className="collapsible" data-collapsible="accordion">
        <a href="/users">
          <li id="dash_users">
            <div
              id="dash_users_header"
              className="collapsible-header waves-effect"
            >
              <b>Users</b>
            </div>
          </li>
        </a>

        <a href="/stays">
          <li id="dash_products">
            <div
              id="dash_products_header"
              className="collapsible-header waves-effect"
            >
              <b>Stays</b>
            </div>
          </li>
        </a>

        <a href="/attractions">
          <li id="dash_categories">
            <div
              id="dash_categories_header"
              className="collapsible-header waves-effect"
            >
              <b>Attractions</b>
            </div>
          </li>
        </a>

        <a href="/orders">
          <li id="dash_brands">
            <div
              id="dash_brands_header"
              className="collapsible-header waves-effect"
            >
              <b>Orders</b>
            </div>
          </li>
        </a>
      </ul>
    </ul>
  );
}

export default Sidebar;

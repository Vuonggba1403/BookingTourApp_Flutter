function Card({ name, icon, link }) {
  return (
    <div className="col s6" style={{ minWidth: '375px' }}>
      <a href={link}>
        <div style={{ padding: '35px' }} align="center" className="card">
          <div className="row">
            <div className="center card-title" style={{color: "black"}}>
              <b>{name} Management</b>
            </div>
          </div>
          <div className="row">
            <div
              style={{ padding: '30px' }}
              className="grey lighten-3  waves-effect"
            >
              <i className="indigo-text text-lighten-1 large material-icons">
                {icon}
              </i>
            </div>
          </div>
        </div>
      </a>
    </div>
  );
}

export default Card;

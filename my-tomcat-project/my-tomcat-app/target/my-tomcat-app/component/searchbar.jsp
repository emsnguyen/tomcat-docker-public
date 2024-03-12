
    <div class="s009">
      <form action="/my-tomcat-app/home/search" method="post" >
        <div class="inner-form">
          <div class="advance-search">
            <div class="row">
                <div class = col-6>
                    <label>Name</label>
                    <div class="input-field">
                        <input type="text" name="name" id="name" placeholder="name" />
                    </div>
                </div>
                <div class = col-3>
                    <label>Age</label>
                    <div class="input-field">
                        <input type="number" name="age" id="minAge" placeholder="0" />
                        ~
                        <input type="number" name="age" id="maxAge" placeholder="0" />
                    </div>
                </div>
                <div class = col-3>
                    <label>Gender</label>
                    <div class="input-field">
                        <label><input type="radio" name="gender" value="1"> Male</label>
                        <label><input type="radio" name="gender" value="0"> Female</label>
                    </div>
                </div>
            </div>
            <div class="row second">
                <div class = col-4>
                    <label>Job</label>
                    <div class="input-field">
                        <div class="input-select">
                        <select data-trigger="" name="choices-single-defaul">
                            <option placeholder="" value="">Select Job</option>
                            <option>Subject b</option>
                            <option>Subject c</option>
                        </select>
                        </div>
                    </div>
               </div>
               <div class = col-5>
                    <label>Email</label>
                    <div class="input-field">
                        <input type="text" name="email" id="email" placeholder="email" />
                    </div>
               </div>
               <div class = col-3>
                    <div class="group-btn">
                        <button class="btn-delete" id="delete">RESET</button>
                        <button type="submit" class="btn-search">SEARCH</button>
                    </div>
               </div>
            </div>
            <div class="row third">
                <div class="clearfix">
					<div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
				</div>
            </div>
          </div>
        </div>
      </form>
    </div>
    <script>
      const customSelects = document.querySelectorAll("select");
      const deleteBtn = document.getElementById('delete')
      const choices = new Choices('select',
      {
        searchEnabled: false,
        itemSelectText: '',
        removeItemButton: true,
      });
      deleteBtn.addEventListener("click", function(e)
      {
        e.preventDefault()
        const deleteAll = document.querySelectorAll('.choices__button')
        for (let i = 0; i < deleteAll.length; i++)
        {
          deleteAll[i].click();
        }
      });

    </script>

